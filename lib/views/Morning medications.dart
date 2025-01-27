import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/Models/ConsumedMedicationModel.dart';
import 'package:medicine_app/config/ConsumedMedication/consumed_medication_bloc.dart';
import 'package:medicine_app/views/Afternoon%20medications.dart';
import 'package:medicine_app/views/Evening%20medications.dart';
import 'package:medicine_app/views/Medicine%20Add.dart';
import 'package:medicine_app/views/Notification.dart';
import 'package:medicine_app/views/SearchPage.dart';
import 'package:medicine_app/views/Update%20medication.dart';

class MorningMedications extends StatefulWidget {
  const MorningMedications({super.key});

  @override
  State<MorningMedications> createState() => _MorningMedicationsState();
}

class _MorningMedicationsState extends State<MorningMedications> {
  void _showDialogSearch(
      BuildContext context, ConsumedMedicationModel details) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(details.drug!.Drug_name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Doctor Name: ${details.Doctor_Name}"),
                SizedBox(height: 8),
                Text("Period: ${details.period}"),
                SizedBox(height: 8),
                Text("Date Prescribed: ${details.Date_Prescibed}")
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
      create: (context) => ConsumedMedicationBloc()..add(GetAllMorning()),
      child: BlocBuilder<ConsumedMedicationBloc, ConsumedMedicationState>(
        builder: (context, state) {
          if (state is ConsumedMedicationLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is ConsumedMedicationSuccess) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: Container(
                height: 60,
                width: 60,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedicineAdd()));
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
                    child: Icon(Icons.search, color: Colors.white, size: 30),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ReminderPage())),
                    icon: Icon(Icons.notifications),
                  )
                ],
                backgroundColor: Color.fromARGB(255, 23, 156, 28),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        child: Image.asset("assets/aid.jpg", fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MorningMedications())),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 41, 203, 47),
                            ),
                            child: Center(
                              child: Text(
                                "Morning\nmedications",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Afternoon_Medications())),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 23, 156, 28),
                            ),
                            child: Center(
                                child: Text(
                              "Afternoon\nmedications",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Evening_Mediactions())),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 23, 156, 28),
                            ),
                            child: Center(
                                child: Text(
                              "Evening\nmedications",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.consumedMedications.length,
                      itemBuilder: (context, index) {
                        var medication = state.consumedMedications[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Card(
                            child: ListTile(
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _showDialogSearch(context,
                                          state.consumedMedications[index]);
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 100, 216, 104),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Icon(Icons.search,
                                            color: Colors.white)),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MedicineUpdate(
                                                    medication: state
                                                            .consumedMedications[
                                                        index],
                                                  )));
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 100, 216, 104),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Icon(Icons.edit,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                              tileColor: Color.fromARGB(255, 41, 203, 47),
                              subtitle: Text(medication.Doctor_Name,
                                  style: TextStyle(color: Colors.white)),
                              title: Text(medication.drug!.Drug_name,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ConsumedMedicationError) {
            return Scaffold(
                body: Center(child: Text("Error: ${state.message}")));
          } else {
            return Center(child: Text(state.runtimeType.toString()));
          }
        },
      ),
    );
  }
}
