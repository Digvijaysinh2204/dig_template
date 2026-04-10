import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as crypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CryptoService extends GetxService {
  final _base64Key = dotenv.env['API_KEY'] ?? 'dummy_key_for_testing_123456789012';
  late final _key = crypt.Key.fromBase64(_base64Key);
  crypt.IV generateIV() {
    final rand = Random.secure();
    final iv = Uint8List(12);
    for (int i = 0; i < 12; i++) {
      iv[i] = rand.nextInt(256);
    }
    return crypt.IV(iv);
  }

  Map<String, String> encryptGCM(String plainText) {
    final iv = generateIV();
    final encrypter = crypt.Encrypter(crypt.AES(_key, mode: crypt.AESMode.gcm));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return {
      'iv': base64Encode(iv.bytes),
      'encrypted': base64Encode(encrypted.bytes),
    };
  }

  String decryptGCM({required String encryptedText, required String ivBase64}) {
    final iv = crypt.IV(base64Decode(ivBase64));
    final encrypter = crypt.Encrypter(crypt.AES(_key, mode: crypt.AESMode.gcm));
    final decrypted = encrypter.decrypt(
      crypt.Encrypted(base64Decode(encryptedText)),
      iv: iv,
    );
    return decrypted;
  }
}
