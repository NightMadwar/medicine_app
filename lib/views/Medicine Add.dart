import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_app/Models/ConsumedMedicationModel.dart';
import 'package:medicine_app/Models/DrugModel.dart';
import 'package:medicine_app/config/ConsumedMedication/consumed_medication_bloc.dart';
import 'package:medicine_app/config/auth/auth_bloc.dart';
import 'package:medicine_app/config/drug/drug_bloc.dart';
import 'package:medicine_app/views/Morning%20medications.dart';

class MedicineAdd extends StatefulWidget {
  const MedicineAdd({super.key});

  @override
  State<MedicineAdd> createState() => _MedicineAddState();
}

class _MedicineAddState extends State<MedicineAdd> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController effectiveMaterialController = TextEditingController();
  TextEditingController sideEffectsController = TextEditingController();
  TextEditingController otherInformationController = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController datePrescribedController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _selectedPeriod;
  List<String> _dropdownValues = [
    "morning",
    "afternoon",
    "evening",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConsumedMedicationBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(width: 20),
              SizedBox(width: 15),
            ],
            backgroundColor: Color.fromARGB(255, 23, 156, 28),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Drug Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Drug name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: effectiveMaterialController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Effective Material',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Effective Material';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: sideEffectsController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Side Effects',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Side Effects';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: otherInformationController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Other Information',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Other Information';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: doctorNameController,
                      decoration: InputDecoration(
                        labelText: 'Doctor Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Doctor Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: datePrescribedController,
                      decoration: InputDecoration(
                        labelText: 'Date Prescribed',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            datePrescribedController.text =
                                pickedDate.toString();
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Period",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      value: _selectedPeriod,
                      items: _dropdownValues.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPeriod = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a period';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {
                        final pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          if (pickedFile != null) {
                            _selectedImage = File(pickedFile.path);
                          } else {
                            print("No Image selected");
                          }
                        });
                      },
                      child: Text(
                        "Select an image",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 41, 203, 47),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _selectedImage != null
                        ? Image.file(_selectedImage!)
                        : Text("Please select an image"),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _selectedImage != null) {
                          context.read<ConsumedMedicationBloc>().add(
                                PostMedication(
                                  DrugModel(
                                    Drug_name: nameController.text,
                                    Effective_Material:
                                        effectiveMaterialController.text,
                                    Side_Effects: sideEffectsController.text,
                                    Other_Information:
                                        otherInformationController.text,
                                    image: _selectedImage!.path,
                                  ),
                                  ConsumedMedicationModel(
                                    Doctor_Name: doctorNameController.text,
                                    User_ID: 1, // Replace with actual user ID
                                    Date_Prescibed:
                                        datePrescribedController.text,
                                    period: _selectedPeriod!, Drug_ID: 1,
                                  ),
                                ),
                              );
                          Future.delayed(Duration(seconds: 5));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MorningMedications()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Please complete the form and select an image')),
                          );
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 41, 203, 47),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        datePrescribedController.text = pickedDate.toString();
      });
    }
  }
}
