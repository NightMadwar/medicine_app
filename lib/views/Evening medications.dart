import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:medicine_app/config/ConsumedMedication/consumed_medication_bloc.dart';
import 'package:medicine_app/views/Afternoon%20medications.dart';
import 'package:medicine_app/views/Medicine%20Add.dart';
import 'package:medicine_app/views/Morning%20medications.dart';
import 'package:medicine_app/views/Notification.dart';
import 'package:medicine_app/views/SearchPage.dart';

class Details {
  String? title;
  String? Description;
  int? numberofpotion;
  String? SuperVisor;
  Details({this.title, this.Description, this.numberofpotion, this.SuperVisor});
}

class Evening_Mediactions extends StatefulWidget {
  const Evening_Mediactions({super.key});

  @override
  State<Evening_Mediactions> createState() => _Evening_MediactionsState();
}

class _Evening_MediactionsState extends State<Evening_Mediactions> {
  List<Details> Detailes = [
    Details(
        title: "cetamool",
        Description: "....",
        numberofpotion: 2,
        SuperVisor: "Dr adeeb"),
    Details(
        title: "panadol 500ml",
        Description: "....",
        numberofpotion: 2,
        SuperVisor: "Dr Taj"),
    Details(
        title: "vetamin",
        Description: "....",
        numberofpotion: 2,
        SuperVisor: "dr mahmoud"),
    Details(
        title: "MobileAPP",
        Description: "....",
        numberofpotion: 2,
        SuperVisor: "Dr Taj"),
    Details(
        title: "Face Detector",
        Description: "....",
        numberofpotion: 2,
        SuperVisor: "Dr Taj"),
    Details(
        title: "chat with bot",
        Description: "....",
        numberofpotion: 2,
        SuperVisor: "Dr Taj"),
    Details(
        title: "Smart Hourse",
        Description: "....",
        numberofpotion: 2,
        SuperVisor: "Dr Taj"),
  ];
  void _showDialogsearch(BuildContext context, Details details) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(details.title!),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description: ${details.Description}"),
                SizedBox(height: 8),
                Text("Number of potion: ${details.numberofpotion}"),
                SizedBox(height: 8),
                Text("Doctor: ${details.SuperVisor}"),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConsumedMedicationBloc()..add(GetAllEvening()),
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: Container(
            height: 60,
            width: 60,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MedicineAdd()));
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5))
              ],
            ),
          ),
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage())),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReminderPage())),
                  icon: Icon(Icons.notifications))
            ],
            backgroundColor: Color.fromARGB(255, 23, 156, 28),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/aid.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Morning_medications()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 23, 156, 28),
                      ),
                      child: Center(
                        child: Text(
                          "Morning\nmedications",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Afternoon_Medications()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 23, 156, 28),
                      ),
                      child: Center(
                          child: Text(
                        "Afternoon\nmedications",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 41, 203, 47),
                    ),
                    child: Center(
                        child: Text(
                      "Evening\nmedications",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                    width: double.infinity,
                    height: 50,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            BlocBuilder<ConsumedMedicationBloc, ConsumedMedicationState>(
              builder: (context, state) {
                if (state is ConsumedMedicationLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ConsumedMedicationSuccess) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.consumedMedications.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Card(
                            child: ListTile(
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _showDialogsearch(
                                          context, Detailes[index]);
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 100, 216, 104),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showDialogsearch(
                                          context, Detailes[index]);
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 100, 216, 104),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              tileColor: Color.fromARGB(255, 41, 203, 47),
                              subtitle: Text(
                                state.consumedMedications[index].Doctor_Name,
                                style: TextStyle(color: Colors.white),
                              ),
                              title: Text(
                                state
                                    .consumedMedications[index].drug!.Drug_name,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text(state.runtimeType.toString()));
                }
              },
            ),
          ]),
        );
      }),
    );
  }
}
