import 'dart:convert';
import 'package:http/http.dart' as http;

// Apna Firebase "Web API Key" yahan paste karna hai (baad me Step 8 me batayenge).
const String kFirebaseApiKey = 'YOUR_FIREBASE_WEB_API_KEY_HERE';

class AuthResult {
  final bool success;
  final String? idToken;
  final String? email;
  final String? errorMessage;

  AuthResult({required this.success, this.idToken, this.email, this.errorMessage});
}

class FirebaseAuthService {
  static String get _signUpUrl =>
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$kFirebaseApiKey';
  static String get _signInUrl =>
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$kFirebaseApiKey';

  static Future<AuthResult> signUp(String email, String password) async {
    return _authRequest(_signUpUrl, email, password);
  }

  static Future<AuthResult> signIn(String email, String password) async {
    return _authRequest(_signInUrl, email, password);
  }

  static Future<AuthResult> _authRequest(String url, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return AuthResult(success: true, idToken: data['idToken'], email: data['email']);
      } else {
        final message = data['error']?['message'] ?? 'Unknown error';
        return AuthResult(success: false, errorMessage: _friendlyError(message));
      }
    } catch (e) {
      return AuthResult(success: false, errorMessage: 'Internet connection check karein.');
    }
  }

  static String _friendlyError(String code) {
    if (code.contains('EMAIL_EXISTS')) return 'Yeh email already registered hai. Login karein.';
    if (code.contains('EMAIL_NOT_FOUND')) return 'Yeh email registered nahi hai. Pehle sign up karein.';
    if (code.contains('INVALID_PASSWORD') || code.contains('INVALID_LOGIN_CREDENTIALS')) {
      return 'Email ya password galat hai.';
    }
    if (code.contains('WEAK_PASSWORD')) return 'Password kam se kam 6 characters ka hona chahiye.';
    if (code.contains('INVALID_EMAIL')) return 'Email sahi format me daalen.';
    return 'Kuch galat ho gaya: $code';
  }
}
