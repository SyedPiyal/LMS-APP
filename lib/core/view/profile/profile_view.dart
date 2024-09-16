import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../database/database.dart';

class ProfileScreen extends StatefulWidget {
  final int userId; // User ID passed to this screen

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey =
      GlobalKey<FormState>(); // Key to identify the form and validate it
  late TextEditingController
      _usernameController; // Controller for username input
  late TextEditingController _emailController; // Controller for email input
  late TextEditingController
      _passwordController; // Controller for password input
  late TextEditingController
      _mobileNumberController; // Controller for mobile number input
  bool _obscurePassword = true; // To toggle password visibility

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _mobileNumberController = TextEditingController();
    // Load user data from the database
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final dbHelper = DatabaseHelper(); // Instance of database helper
    final user =
        await dbHelper.getUserById(widget.userId); // Fetch user data by ID
    if (user != null) {
      setState(() {
        // Populate controllers with user data
        _usernameController.text = user['username'];
        _emailController.text = user['email'];
        _passwordController.text = user['password'];
        _mobileNumberController.text =
            user['mobile_number'] ?? ''; // Handle null value
      });
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Validate form
      final dbHelper = DatabaseHelper(); // Instance of database helper
      await dbHelper.updateUser(
        widget.userId,
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
        _mobileNumberController.text,
      );
      // Show success message and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context); // Close the profile screen
    } else {
      // Show error message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile update failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'), // Title of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Form(
          key: _formKey, // Attach form key to the form
          child: Column(
            children: [
              // Username input field
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username'; // Validation message
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Spacer

              // Email input field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'; // Validation message
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Spacer

              // Mobile number input field
              TextFormField(
                controller: _mobileNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[+0-9]'))
                ],
                // Allow only numbers
                keyboardType: TextInputType.phone,
                // Phone number keyboard
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number'; // Validation message
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Spacer

              // Password input field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword, // Toggle password visibility
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                            !_obscurePassword; // Toggle password visibility
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password'; // Validation message
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Spacer

              // Update profile button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateUserData, // Update user data on press
                  child: const Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
