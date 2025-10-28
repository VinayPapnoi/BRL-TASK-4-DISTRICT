import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Verify phone number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(String) verificationFailed,
    required Function(String) codeSent,
    required Function() codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        verificationCompleted(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        String errorMessage;
        switch (e.code) {
          case 'invalid-phone-number':
            errorMessage = 'The phone number is invalid';
            break;
          case 'too-many-requests':
            errorMessage = 'Too many requests. Please try again later';
            break;
          default:
            errorMessage = e.message ?? 'An error occurred';
        }
        verificationFailed(errorMessage);
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        codeAutoRetrievalTimeout();
      },
    );
  }

  // Sign in with credential
  Future<UserCredential> signInWithCredential(PhoneAuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

  // Verify OTP
  Future<bool> verifyOTP({
    required String verificationId,
    required String otp,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      
      await _auth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      print('Error verifying OTP: ${e.code}');
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}