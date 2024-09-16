import 'package:flutter/material.dart';
import 'package:lms_app/utils/extensions/context_ext.dart';

import '../../database/database.dart';
import '../dashboard/dashboard_view.dart';
import '../signup/signup_view.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // GlobalKey for the Form widget to manage its state
  final _formKey = GlobalKey<FormState>();
  // Boolean to toggle password visibility
  bool _obscureText = true;

  // Controllers for the username and password text fields
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Accessing theme data from the context
    final theme = context.theme;
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing when keyboard is visible
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Welcome message
            Text(
              "Hello there, \nwelcome back",
              style: theme.textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40), // Spacer
            Form(
              key: _formKey, // Connects Form with its key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Container for form fields with decoration
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: <Widget>[
                        // Username input field
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: _usernameCtrl, // Set controller for username
                            decoration: const InputDecoration(
                              labelText: "Username",
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                        ),
                        // Password input field
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: _passwordCtrl, // Set controller for password
                            obscureText: _obscureText, // Toggle password visibility
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  // Toggle password visibility on icon press
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Forgot password button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Spacer
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final dbHelper = DatabaseHelper();
                          final user = await dbHelper.getUser(
                            _usernameCtrl.text,
                            _passwordCtrl.text,
                          );

                          if (user != null) {
                            // Navigate to DashboardScreen on successful login
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ),
                            );
                          } else {
                            // Show error message if login fails
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid username or password')),
                            );
                          }
                        }
                      },
                      child: const Text('Log In'),
                    ),
                  ),
                  // Navigate to SignUpView for account creation
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpView(),
                          ),
                        );
                      },
                      child: Text(
                        "Create Account",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
