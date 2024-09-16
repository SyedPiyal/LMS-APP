import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms_app/utils/extensions/context_ext.dart';


import '../../database/database.dart';
import '../login/login_view.dart';
import '../otp/otp_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  //---------->
  //--> variables
  //---------->
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isConsentTaken = false;

  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _mobileNumberCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPassCtrl = TextEditingController();

  //---------->
  //--> build method
  //---------->
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            // -----------------------------------
            // Registration Overview
            // -----------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //----------> banner <----------//
                  Text(
                    "Registration",
                    style: theme.textTheme.displayLarge,
                  ),

                  Container(
                    margin: const EdgeInsets.only(
                      top: 25,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //----------> registration hint and info <----------//
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\u2022",
                              style: theme.textTheme.bodySmall,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Please fill in this form to create an account.",
                                style: theme.textTheme.bodySmall,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // -----------------------------------
            // Main Form
            // -----------------------------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //----------> user name <----------//
                    TextFormField(
                      controller: _userNameCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return "User Name is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Enter User Name",
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //----------> mobile number <----------//
                    TextFormField(
                      controller: _mobileNumberCtrl,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[+0-9]'))
                      ],
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return "Mobile Number is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Enter Mobile Number",
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //----------> Email <----------//
                    TextFormField(
                      controller: _emailCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return "Email is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Enter Email",
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //----------> password <----------//
                    TextFormField(
                      controller: _passwordCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(_obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //----------> confirm password <----------//
                    TextFormField(
                      controller: _confirmPassCtrl,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == "" ||
                            _passwordCtrl.text != _confirmPassCtrl.text) {
                          return "Password didn't match";
                        }
                        return null;
                      },
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: "Enter Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: Icon(_obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //----------> register button <----------//
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final dbHelper = DatabaseHelper();
                            await dbHelper.insertUser(
                              _userNameCtrl.text,
                              _emailCtrl.text,
                              _passwordCtrl.text,
                              _mobileNumberCtrl.text,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const OtpView()),
                            );
                          }
                        },

                        child: const Text("Register"),
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    //----------> login message <----------//
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 3),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(6),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 3),
                              child: Text(
                                'Sign In',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
