import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Auth state model
class AuthState {
  final String phoneNumber;
  final String countryCode;
  final bool isAuthenticated;
  final bool isLoading;
  final String? verificationId; // For OTP verification

  AuthState({
    this.phoneNumber = '',
    this.countryCode = '+91',
    this.isAuthenticated = false,
    this.isLoading = false,
    this.verificationId,
  });

  AuthState copyWith({
    String? phoneNumber,
    String? countryCode,
    bool? isAuthenticated,
    bool? isLoading,
    String? verificationId,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      verificationId: verificationId ?? this.verificationId,
    );
  }
}

// Auth notifier
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void updatePhoneNumber(String phone) {
    state = state.copyWith(phoneNumber: phone);
  }

  void updateCountryCode(String code) {
    state = state.copyWith(countryCode: code);
  }

  Future<void> submitPhoneNumber() async {
    if (state.phoneNumber.length != 10) return;

    state = state.copyWith(isLoading: true);

    final fullPhone = '${state.countryCode}${state.phoneNumber}';

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullPhone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-sign in if possible
        await FirebaseAuth.instance.signInWithCredential(credential);
        state = state.copyWith(isLoading: false, isAuthenticated: true);
      },
      verificationFailed: (FirebaseAuthException e) {
        state = state.copyWith(isLoading: false);
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        state = state.copyWith(
          isLoading: false,
          verificationId: verificationId,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        state = state.copyWith(verificationId: verificationId);
      },
    );
  }

  Future<void> verifyOTP(String smsCode) async {
    if (state.verificationId == null) return;

    state = state.copyWith(isLoading: true);

    final credential = PhoneAuthProvider.credential(
      verificationId: state.verificationId!,
      smsCode: smsCode,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      state = state.copyWith(isLoading: false, isAuthenticated: true);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      print('OTP verification failed: ${e.message}');
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    state = AuthState();
  }

  bool get isPhoneNumberValid => state.phoneNumber.length == 10;
}

// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Computed provider for button enabled state
final isLoginButtonEnabledProvider = Provider<bool>((ref) {
  final phoneNumber = ref.watch(authProvider).phoneNumber;
  return phoneNumber.length == 10;
});
