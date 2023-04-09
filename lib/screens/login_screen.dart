import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:simple_animations/simple_animations.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  bool _isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
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
                        fontWeight: FontWeight.w600,
                      ),
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
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email ID",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                          size: 16,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter a valid Email ID"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 16,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _isObscure = !_isObscure;
                              },
                            );
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Required"),
                          MinLengthValidator(
                            6,
                            errorText:
                                "Password must be atleast 6 characters long",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          // Incomplete
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      height: 60,
                      width: 250,
                      child: SizedBox(
                        height: 50,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            // Incomplete
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent,
                            onPrimary: Colors.pinkAccent,
                            onSurface: Colors.pinkAccent,
                            shadowColor: Colors.pinkAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Opacity(
                                opacity: 0,
                                child: Icon(Icons.arrow_forward),
                              ),
                              const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                padding: const EdgeInsets.all(1.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.pink[400],
                                  child: IconButton(
                                    icon: _isLoading
                                        ? Container(
                                            width: 24,
                                            height: 24,
                                            padding: const EdgeInsets.all(2.0),
                                            child:
                                                const CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.arrow_forward,
                                            size: 18,
                                          ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        // Call the login function
                                        print("Valid user... about to login");
                                        setState(
                                          () {
                                            _isLoading = !_isLoading;
                                          },
                                        );
                                      } else {
                                        print("Not valid");
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Powered by ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Incomplete
                        },
                        child: const Text(
                          "QR memo",
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
