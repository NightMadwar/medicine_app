import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/config/auth/auth_bloc.dart';
import 'package:medicine_app/views/Morning%20medications.dart';
import 'package:medicine_app/views/Sign%20Up.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController NameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Success) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Success",
                  style: TextStyle(color: Colors.green),
                ),
              ));
              Future.delayed(const Duration(seconds: 2));
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MorningMedications()));
            }
            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
              ));
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 23, 156, 28),
                      Color.fromARGB(255, 41, 203, 47),
                      Color.fromARGB(255, 100, 216, 104),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Icon(
                      Icons.local_hospital_outlined,
                      size: 120,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Medicines management",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Welcome",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Please Login to your account",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 250,
                                child: TextFormField(
                                  controller: NameController,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    ),
                                    labelText: "Email Address",
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    suffixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 250,
                                child: TextFormField(
                                  controller: PasswordController,
                                  obscureText: _isObscured,
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    ),
                                    labelText: "Password",
                                    labelStyle:
                                        const TextStyle(color: Colors.black54),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    "Forget password?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<AuthBloc>().add(Login(
                                      User_Name: NameController.text,
                                      Password: PasswordController.text));
                                },
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: const Center(
                                    child: Text(
                                      "Log in",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Don\'t have an account?",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 17),
                                  children: [
                                    TextSpan(
                                      text: " Sign up",
                                      style:
                                          const TextStyle(color: Colors.green),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUp()),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                              if (state is Loading)
                                const SizedBox(
                                  height: 30,
                                ),
                              if (state is Loading)
                                const CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
