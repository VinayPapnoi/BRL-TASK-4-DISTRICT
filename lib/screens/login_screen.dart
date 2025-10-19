import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            // Top section with logo and illustration
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // District logo
                  Image.asset(
                    'assets/images/district_logo.png',
                    width: 120,
                  ),
                  const SizedBox(height: 40),

                  // Placeholder for 3D illustration
                  // You'll need to add the actual illustration image
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Placeholder for the 3D pins illustration
                        Icon(
                          Icons.location_on,
                          size: 100,
                          color: AppColors.primaryPurple.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tagline
                  const Text(
                    'One app for all your going out plans',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Bottom section with login form
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Log in or sign up text
                    const Text(
                      'Log in or sign up',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Phone number input
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          // Country flag and code
                          Image.asset(
                            'assets/images/india_flag.png',
                            width: 24,
                            height: 16,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text(
                                '🇮🇳',
                                style: TextStyle(fontSize: 20),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '+91',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 16),

                          // Phone number field
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                hintText: '10-digit mobile number',
                                hintStyle: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Continue button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle continue action
                          if (_phoneController.text.length == 10) {
                            // Navigate to OTP screen or next step
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Phone number submitted!'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Terms and privacy text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                        children: [
                          const TextSpan(text: 'By continuing, you agree to our\n'),
                          TextSpan(
                            text: 'Terms of Services',
                            style: TextStyle(
                              color: AppColors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: '     '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
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