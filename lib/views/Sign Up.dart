import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/Models/UserModel.dart';
import 'package:medicine_app/config/auth/auth_bloc.dart';
import 'package:medicine_app/views/LogIn.dart';
import 'package:medicine_app/views/Morning%20medications.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController NameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController LocationController = TextEditingController();
  TextEditingController HeightController = TextEditingController();
  TextEditingController WeightController = TextEditingController();
  bool _isObscured = true;
  String? _selectedValue;
  List<String> _dropdownValues = [
    'male',
    'female',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
            if (state is Success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "Success",
                style: TextStyle(color: Colors.green),
              )));
            }
          },
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Expanded(
                      flex: 5,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                              Color.fromARGB(255, 23, 156, 28),
                              Color.fromARGB(255, 41, 203, 47),
                              Color.fromARGB(255, 100, 216, 104),
                            ])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Icon(
                              Icons.local_hospital_outlined,
                              size: 120,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Medicines managment",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              flex: 14,
                              child: Container(
                                height: 400,
                                width: 325,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Please write your information",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width: 250,
                                        child: TextFormField(
                                          controller: NameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please type your user name";
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            labelText: "User name",
                                            labelStyle: TextStyle(
                                                color: Colors.black54),
                                            suffixIcon: Icon(
                                              Icons.person,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width: 250,
                                        child: TextFormField(
                                          controller: EmailController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please type your email";
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            labelText: "ُEmail",
                                            labelStyle: TextStyle(
                                                color: Colors.black54),
                                            suffixIcon: Icon(
                                              Icons.email_outlined,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 37,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              height: 50,
                                              child: TextFormField(
                                                controller: AgeController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "please type your Birthday";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: BorderSide(
                                                          color: Colors.green)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green)),
                                                  labelText: "ُBirthdate",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                                readOnly: true,
                                                onTap: () {
                                                  _selectDate();
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              height: 50,
                                              child: TextFormField(
                                                controller: HeightController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "please type your height";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: BorderSide(
                                                          color: Colors.green)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green)),
                                                  labelText: "ُHeight",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 37,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 37,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              height: 50,
                                              child: TextFormField(
                                                controller: WeightController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "please type your Weight";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: BorderSide(
                                                          color: Colors.green)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green)),
                                                  labelText: "ُWeight",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                                height: 50,
                                                child: DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                    labelText: "Gender",
                                                    labelStyle: TextStyle(
                                                        color: Colors.black54),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .green)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .green)),
                                                  ),
                                                  value: _selectedValue,
                                                  icon: null,
                                                  items: _dropdownValues
                                                      .map((String value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      _selectedValue = newValue;
                                                    });
                                                  },
                                                )),
                                          ),
                                          SizedBox(
                                            width: 37,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width: 250,
                                        child: TextFormField(
                                          controller: PasswordController,
                                          obscureText: _isObscured,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            labelText: "Password",
                                            labelStyle: TextStyle(
                                                color: Colors.black54),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _isObscured
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscured = !_isObscured;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: TextFormField(
                                        controller: LocationController,
                                        obscureText: _isObscured,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.green)),
                                            labelText: "Location",
                                            labelStyle: TextStyle(
                                                color: Colors.black54),
                                            suffixIcon: Icon(
                                              Icons.location_on,
                                              color: Colors.green,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<AuthBloc>().add(Register(
                                            user: UserModel(
                                                User_Name: NameController.text,
                                                Password:
                                                    PasswordController.text,
                                                Email: EmailController.text,
                                                Gender: _selectedValue,
                                                Age: AgeController.text,
                                                Height: double.parse(
                                                    HeightController.text),
                                                Weight: double.parse(
                                                    WeightController.text),
                                                User_Location:
                                                    LocationController.text)));

                                        Future.delayed(Duration(seconds: 5));
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Morning_medications()));
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Center(
                                          child: Text(
                                            "Sign Up",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "You already have an account?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17),
                                          children: [
                                            TextSpan(
                                                text: " Log In",
                                                style: TextStyle(
                                                    color: Colors.green),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LogIn()));
                                                      })
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          },
        );
      }),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        AgeController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }
}
