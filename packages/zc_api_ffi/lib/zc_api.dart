
import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'ffi.dart' as zc_ffi;

class KeyPackage {
  String phrase = "";
  String spendingKey = "";
  String address = "";

  KeyPackage(this.phrase, this.spendingKey, this.address);
}

class ZcApi {
  static const MethodChannel _channel =
  const MethodChannel('zc_api');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static bool initialize(String databasePath) {
    return zc_ffi.initialize(Utf8.toUtf8(databasePath)) != 0;
  }

  static KeyPackage initAccount(String databasePath) {
    final keys = zc_ffi.init_account(Utf8.toUtf8(databasePath));
    return KeyPackage(
        Utf8.fromUtf8(keys.phrase),
        Utf8.fromUtf8(keys.spending_key),
        Utf8.fromUtf8(keys.address));
  }

  static int sync(String databasePath, int maxBlocks) {
    final n = zc_ffi.sync(Utf8.toUtf8(databasePath), maxBlocks);
    return n;
  }

  static int getBalance(String databasePath) {
    final n = zc_ffi.get_balance(Utf8.toUtf8(databasePath));
    return n;
  }

  static void send(String databasePath, String address, double amount,
      String spendingKey,
      ByteData sendParams, ByteData outputParams) {
    final sats = (amount * 100000000).round();
    final sendP = castParams(sendParams);
    final outputP = castParams(outputParams);
    zc_ffi.send_tx(
        Utf8.toUtf8(databasePath),
        Utf8.toUtf8(address),
        sats,
        Utf8.toUtf8(spendingKey),
        sendP,
        sendParams.lengthInBytes,
        outputP,
        outputParams.lengthInBytes);
    free(sendP);
    free(outputP);
  }

  static Pointer<Utf8> castParams(ByteData params) {
    final bb = params.buffer;
    final Pointer<Uint8> result = allocate<Uint8>(count: bb.lengthInBytes);
    final nativeParams = result.asTypedList(bb.lengthInBytes);
    nativeParams.setAll(0, bb.asUint8List());
    return result.cast();
  }

  static bool checkAddress(String address) {
    return zc_ffi.check_address(Utf8.toUtf8(address)) != 0;
  }
}
