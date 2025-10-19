import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/colors.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isButtonEnabled = ref.watch(isLoginButtonEnabledProvider);

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
                  SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
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
                          const Text(
                            '🇮🇳',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            authState.countryCode,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 16),

                          // Phone number field
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                ref.read(authProvider.notifier).updatePhoneNumber(value);
                              },
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
                        onPressed: authState.isLoading
                            ? null
                            : (isButtonEnabled
                                ? () async {
                                    await ref.read(authProvider.notifier).submitPhoneNumber();
                                    if (context.mounted) {
                                      final currentAuthState = ref.read(authProvider);
                                      if (currentAuthState.isAuthenticated) {
                                        Navigator.pushReplacementNamed(context, '/home');
                                      }
                                    }
                                  }
                                : null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled
                              ? AppColors.primaryPurple
                              : AppColors.buttonGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          disabledBackgroundColor: AppColors.buttonGrey,
                        ),
                        child: authState.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : Text(
                                'Continue',
                                style: TextStyle(
                                  color: isButtonEnabled
                                      ? AppColors.white
                                      : AppColors.textSecondary,
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
                      text: const TextSpan(
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(text: 'By continuing, you agree to our\n'),
                          TextSpan(
                            text: 'Terms of Services',
                            style: TextStyle(
                              color: AppColors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: '     '),
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