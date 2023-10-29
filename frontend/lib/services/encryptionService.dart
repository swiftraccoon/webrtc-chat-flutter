import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:asn1lib/asn1lib.dart';

class EncryptionService {
  AsymmetricKeyPair<PublicKey, PrivateKey> generateKeys() {
    final keyParams = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64);
    final secureRandom = FortunaRandom();
    final keyGenerator = RSAKeyGenerator()
      ..init(ParametersWithRandom(keyParams, secureRandom));
    final pair = keyGenerator.generateKeyPair();
    return pair;
  }

  String exportPublicKey(RSAPublicKey publicKey) {
    final encoder = ASN1Sequence();
    encoder.add(ASN1Integer(publicKey.modulus!));
    encoder.add(ASN1Integer(publicKey.exponent!));
    final dataBase64 = base64.encode(encoder.encodedBytes);
    return dataBase64;
  }

  RSAPublicKey importPublicKey(String publicKeyString) {
    final publicKeyBytes = base64.decode(publicKeyString);
    final asn1Parser = ASN1Parser(Uint8List.fromList(publicKeyBytes));
    final publicKeySeq = asn1Parser.nextObject() as ASN1Sequence;
    final modulus = (publicKeySeq.elements[0] as ASN1Integer).valueAsBigInteger;
    final exponent = (publicKeySeq.elements[1] as ASN1Integer).valueAsBigInteger;
    return RSAPublicKey(modulus, exponent);
  }

  String encryptMessage(String plaintext, RSAPublicKey publicKey) {
    final encryptor = RSAEngine()
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
    final encrypted = encryptor.process(Uint8List.fromList(utf8.encode(plaintext)));
    return base64.encode(encrypted);
  }

  String decryptMessage(String ciphertext, RSAPrivateKey privateKey) {
    final decryptor = RSAEngine()
      ..init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    final decrypted = decryptor.process(base64.decode(ciphertext));
    return utf8.decode(decrypted);
  }

  String exportPrivateKey(RSAPrivateKey privateKey) {
    // Export private key to a secure, storable format
    // For this example, using a placeholder
    return privateKey.modulus.toString();
    }

}
