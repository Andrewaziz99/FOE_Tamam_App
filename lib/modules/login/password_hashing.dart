import 'dart:convert';
import 'package:crypto/crypto.dart';

class PasswordHasher {
  // Generate a secure hash using SHA-256
  static String hashPassword(String password) {
    // Convert the password string to bytes
    final bytes = utf8.encode(password);

    // Generate the hash
    final hash = sha256.convert(bytes);

    // Return the hash as a hex string
    return hash.toString();
  }

  // Optional: Add salt for additional security
  static String hashPasswordWithSalt(String password, String salt) {
    // Combine password and salt
    final saltedPassword = password + salt;

    // Convert the salted password to bytes
    final bytes = utf8.encode(saltedPassword);

    // Generate the hash
    final hash = sha256.convert(bytes);

    // Return the hash as a hex string
    return hash.toString();
  }

  // Generate a random salt (useful for the salted version)
  static String generateSalt() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return base64Encode(utf8.encode(random));
  }
}