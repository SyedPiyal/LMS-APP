import 'package:flutter/material.dart';
import '../dashboard/dashboard_view.dart';
import 'otp_input.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  // Controllers for each OTP input field to manage their text input
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spacer to push the content down from the top
            const SizedBox(height: 70),

            // Title of the screen
            const Text(
              'Verify your identity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            // Spacer between title and instruction
            const SizedBox(height: 30),

            // Instruction text
            const Text(
              'Enter the 4-digit code sent to your phone number',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),

            // Spacer between instruction and OTP fields
            const SizedBox(height: 50),

            // Row of OTP input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Custom OTP input field widgets
                OtpInput(controller: _fieldOne, autoFocus: true),
                OtpInput(controller: _fieldTwo, autoFocus: false),
                OtpInput(controller: _fieldThree, autoFocus: false),
                OtpInput(controller: _fieldFour, autoFocus: false),
              ],
            ),

            // Spacer between OTP fields and submit button
            const SizedBox(height: 50),

            // Submit button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Concatenate the text from each OTP field to form the complete PIN
                    final String pin = _fieldOne.text +
                        _fieldTwo.text +
                        _fieldThree.text +
                        _fieldFour.text;

                    // Check if the PIN length is exactly 4
                    if (pin.length == 4) {
                      // Show a snackbar with the confirmed PIN
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: SizedBox(
                            height: 60,
                            child: Text(
                              'Your PIN is confirmed: $pin',
                            ),
                          ),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                      );
                    } else {
                      // Handle invalid PIN length
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: SizedBox(
                            height: 60,
                            child: Text(
                              'Please enter a valid 4-digit PIN.',
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
