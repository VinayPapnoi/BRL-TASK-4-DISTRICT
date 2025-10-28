import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_auth_services.dart';

// Auth State Model
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final String phoneNumber;
  final String countryCode;
  final String? verificationId;
  final String? userId;

  AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
    this.phoneNumber = '',
    this.countryCode = '+91',
    this.verificationId,
    this.userId,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
    String? phoneNumber,
    String? countryCode,
    String? verificationId,
    String? userId,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      verificationId: verificationId ?? this.verificationId,
      userId: userId ?? this.userId,
    );
  }
}

// Auth Provider
class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuthService _authService;

  AuthNotifier(this._authService) : super(AuthState()) {
    _checkAuthStatus();
  }

  // Check if user is already logged in
  Future<void> _checkAuthStatus() async {
    final user = _authService.currentUser;
    if (user != null) {
      state = state.copyWith(
        isAuthenticated: true,
        userId: user.uid,
        phoneNumber: user.phoneNumber ?? '',
      );
    }
  }

  // Update phone number
  void updatePhoneNumber(String number) {
    state = state.copyWith(phoneNumber: number, error: null);
  }

  // Submit phone number for OTP
  Future<void> submitPhoneNumber() async {
    if (state.phoneNumber.length != 10) {
      state = state.copyWith(error: 'Please enter a valid 10-digit number');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final fullPhoneNumber = '${state.countryCode}${state.phoneNumber}';
      
      await _authService.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (credential) async {
          // Auto-verification (Android only)
          await _authService.signInWithCredential(credential);
          state = state.copyWith(
            isAuthenticated: true,
            isLoading: false,
            userId: _authService.currentUser?.uid,
          );
        },
        verificationFailed: (error) {
          state = state.copyWith(
            isLoading: false,
            error: error,
          );
        },
        codeSent: (verificationId) {
          state = state.copyWith(
            isLoading: false,
            verificationId: verificationId,
          );
        },
        codeAutoRetrievalTimeout: () {
          state = state.copyWith(isLoading: false);
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Verify OTP
  Future<bool> verifyOTP(String otp) async {
    if (state.verificationId == null) {
      state = state.copyWith(error: 'Verification ID not found');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _authService.verifyOTP(
        verificationId: state.verificationId!,
        otp: otp,
      );

      if (success) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          userId: _authService.currentUser?.uid,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid OTP',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    await submitPhoneNumber();
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    state = AuthState();
  }

  // Logout (alias for signOut for compatibility)
  Future<void> logout() async {
    await signOut();
  }
}

// Providers
final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});

// Helper provider for button state
final isLoginButtonEnabledProvider = Provider<bool>((ref) {
  final phoneNumber = ref.watch(authProvider.select((state) => state.phoneNumber));
  return phoneNumber.length == 10;
});