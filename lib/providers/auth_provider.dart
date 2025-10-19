import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth state model
class AuthState {
  final String phoneNumber;
  final String countryCode;
  final bool isAuthenticated;
  final bool isLoading;

  AuthState({
    this.phoneNumber = '',
    this.countryCode = '+91',
    this.isAuthenticated = false,
    this.isLoading = false,
  });

  AuthState copyWith({
    String? phoneNumber,
    String? countryCode,
    bool? isAuthenticated,
    bool? isLoading,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
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
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    state = state.copyWith(
      isLoading: false,
      isAuthenticated: true,
    );
  }

  void logout() {
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