import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:simple_animations/simple_animations.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Login UI",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 40,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 40),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Email ID",
                            labelStyle: TextStyle(
                                fontSize: 14, color: Colors.grey.shade400),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.grey,
                              size: 16,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ))),
                      )
                    ],
                  )
                ]),
          ),
        )));
  }
}
