import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';
import 'package:medicine_app/Models/DrugModel.dart';
import 'package:medicine_app/config/drug/drug_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:async'; // Import for Timer

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  late TextEditingController amountController;
  DateTime selectedDateTime = DateTime.now();
  int? selectedDrugId;
  late Dio dio;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    dio = Dio(BaseOptions(baseUrl: 'http://10.0.0.2/api'));

    // Initialize timezone data
    tz.initializeTimeZones();

    // Initialize Flutter Local Notifications
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification response
      if (response.payload != null) {
        debugPrint('notification payload: ${response.payload}');
      }
    });

    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    var notificationStatus = await Permission.notification.status;

    if (!notificationStatus.isGranted) {
      if (await Permission.notification.request().isGranted) {
        // Notification permission granted
      } else {
        _showPermissionDialog('Notification');
      }
    }

    if (await Permission.notification.isDenied) {
      _showPermissionDialog('Post Notification');
    }

    var exactAlarmStatus = await Permission.scheduleExactAlarm.status;
    if (!exactAlarmStatus.isGranted) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  void _showPermissionDialog(String permission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permission Permission Required'),
          content: Text(
              '$permission permission is required to show reminders. Please grant permission.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _scheduleNotification(DateTime dateTime, String message) async {
    await _requestPermissions();

    final Duration delay = dateTime.difference(DateTime.now());
    if (delay.isNegative) {
      print('Selected time is in the past!');
      return;
    }

    Timer(delay, () {
      _showNotification(message);
    });

    print("Notification scheduled for $dateTime with message: $message");
  }

  void _showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.max,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Drug Reminder',
      message,
      platformChannelSpecifics,
      payload: message,
    );
  }

  Future<void> _showDateTimePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });

        // Print the selected date and time
        print("Selected Date and Time: ${selectedDateTime.toIso8601String()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrugBloc()..add(GetAllDrugs()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
                title: Text('Drug Reminder'), backgroundColor: Colors.green),
            body: BlocBuilder<DrugBloc, DrugState>(
              builder: (context, state) {
                if (state is DrugLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is DrugSuccess) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<int>(
                          hint: Text('Select Drug'),
                          value: selectedDrugId,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedDrugId = newValue;
                            });
                          },
                          items: state.drugs.map<DropdownMenuItem<int>>((drug) {
                            return DropdownMenuItem<int>(
                              value: drug.id,
                              child: Text(drug.Drug_name),
                            );
                          }).toList(),
                        ),
                        ElevatedButton(
                          onPressed: () => _showDateTimePicker(context),
                          child: Text('Select Reminder Time'),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: 225,
                          child: TextFormField(
                            controller: amountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please type Amount";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              labelText: "Amount",
                              labelStyle: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            if (selectedDrugId != null) {
                              final drug = state.drugs.firstWhere(
                                  (drug) => drug.id == selectedDrugId);
                              final message =
                                  'Take your medication: ${drug.Drug_name}, Amount: ${amountController.text}';
                              await _scheduleNotification(
                                  selectedDateTime, message);
                            }
                          },
                          child: Text('Schedule Notification'),
                        ),
                      ],
                    ),
                  );
                } else if (state is DrugError) {
                  return Center(child: Text('Failed to load drugs'));
                } else {
                  return Center(child: Text('Unexpected State'));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
