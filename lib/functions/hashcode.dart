import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashN(String id, int n) {
  // Calcula o hash SHA-256 do ID
  List<int> bytes = utf8.encode(id);
  Digest sha256Hash = sha256.convert(bytes);

  // Converte o hash SHA-256 em uma string hexadecimal
  String hexString = sha256Hash.toString();

  // Retorna os primeiros 5 caracteres da string hexadecimal
  return hexString.padLeft(n, '0').substring(0, n).toUpperCase();
}