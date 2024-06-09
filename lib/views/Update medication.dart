import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_app/Models/ConsumedMedicationModel.dart';
import 'package:medicine_app/Models/DrugModel.dart';
import 'package:medicine_app/config/ConsumedMedication/consumed_medication_bloc.dart';
import 'package:medicine_app/views/Morning%20medications.dart';

class MedicineUpdate extends StatefulWidget {
  final ConsumedMedicationModel medication;
  const MedicineUpdate({required this.medication, super.key});

  @override
  State<MedicineUpdate> createState() => _MedicineUpdateState();
}

class _MedicineUpdateState extends State<MedicineUpdate> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _selectedPeriod;

  late TextEditingController nameController;
  late TextEditingController effectiveMaterialController;
  late TextEditingController sideEffectsController;
  late TextEditingController otherInformationController;
  late TextEditingController doctorNameController;
  late TextEditingController datePrescribedController;

  final List<String> _dropdownValues = [
    "morning",
    "afternoon",
    "evening",
  ];

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.medication.drug!.Drug_name);
    effectiveMaterialController =
        TextEditingController(text: widget.medication.drug!.Effective_Material);
    sideEffectsController =
        TextEditingController(text: widget.medication.drug!.Side_Effects);
    otherInformationController =
        TextEditingController(text: widget.medication.drug!.Other_Information);
    doctorNameController =
        TextEditingController(text: widget.medication.Doctor_Name);
    datePrescribedController =
        TextEditingController(text: widget.medication.Date_Prescibed);
    _selectedPeriod = widget.medication.period;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConsumedMedicationBloc(),
      child: BlocListener<ConsumedMedicationBloc, ConsumedMedicationState>(
        listener: (context, state) {
          if (state is ConsumedMedicationLoading) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(
              child: CircularProgressIndicator(),
            )));
          } else if (state is ConsumedMedicationUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(
              child: Text(
                "Medication updated successfully",
                style: TextStyle(color: Colors.green),
              ),
            )));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MorningMedications()));
          } else if (state is ConsumedMedicationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                state.message,
                style: TextStyle(color: Colors.red),
              )),
            );
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {},
                  child: Icon(Icons.search, color: Colors.white, size: 30),
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
                      _buildTextFormField(
                        controller: nameController,
                        label: 'Drug Name',
                        validatorMessage: 'Please enter Drug name',
                      ),
                      SizedBox(height: 15),
                      _buildTextFormField(
                        controller: effectiveMaterialController,
                        label: 'Effective Material',
                        maxLines: 3,
                        validatorMessage: 'Please enter Effective Material',
                      ),
                      SizedBox(height: 15),
                      _buildTextFormField(
                        controller: sideEffectsController,
                        label: 'Side Effects',
                        maxLines: 3,
                        validatorMessage: 'Please enter Side Effects',
                      ),
                      SizedBox(height: 15),
                      _buildTextFormField(
                        controller: otherInformationController,
                        label: 'Other Information',
                        maxLines: 3,
                        validatorMessage: 'Please enter Other Information',
                      ),
                      SizedBox(height: 15),
                      _buildTextFormField(
                        controller: doctorNameController,
                        label: 'Doctor Name',
                        validatorMessage: 'Please enter Doctor Name',
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
                        onTap: _selectDate,
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
                        onPressed: _submitForm,
                        child: Text(
                          "Update",
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
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String validatorMessage,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        return null;
      },
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedDrug = DrugModel(
        id: widget.medication.drug!.id,
        Drug_name: nameController.text,
        Effective_Material: effectiveMaterialController.text,
        Side_Effects: sideEffectsController.text,
        Other_Information: otherInformationController.text,
        image: _selectedImage?.path ?? widget.medication.drug!.image,
      );

      final updatedMedication = ConsumedMedicationModel(
        id: widget.medication.id,
        Doctor_Name: doctorNameController.text,
        User_ID: widget.medication.User_ID,
        Date_Prescibed: datePrescribedController.text,
        period: _selectedPeriod!,
        Drug_ID: widget.medication.Drug_ID,
      );

      context.read<ConsumedMedicationBloc>().add(
            UpdateMedication(
              widget.medication.id!.toInt(),
              updatedDrug,
              updatedMedication,
            ),
          );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MorningMedications()));
    }
  }
}
