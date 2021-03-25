import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zc_api/zc_api.dart';

part 'store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  String databasePath = "";
  ByteData sendParams;
  ByteData outputParams;

  @observable
  double balance = 0.0;

  @observable
  String phrase = "";
  @observable
  String spendingKey = "";
  @observable
  String address = "";

  @observable
  bool syncing = false;

  Future<void> initialize(ByteData sendParams, ByteData outputParams) async {
    this.sendParams = sendParams;
    this.outputParams = outputParams;

    var databasePath = await getDatabasesPath();
    this.databasePath = databasePath;

    final prefs = await SharedPreferences.getInstance();
    final hasAccount = ZcApi.initialize(databasePath);
    if (!hasAccount) {
      final keys = ZcApi.initAccount(databasePath);
      prefs.setString('phrase', keys.phrase);
      prefs.setString('spending_key', keys.spendingKey);
      prefs.setString('address', keys.address);
    }
    phrase = prefs.getString('phrase');
    spendingKey = prefs.getString('spending_key');
    address = prefs.getString('address');
    await sync();
  }

  @action
  Future<void> sync() async {
    int n = 0;
    do {
      n = await compute(syncOne, databasePath);
      balance = ZcApi.getBalance(databasePath) / 100000000.0;
    } while (n > 0 && syncing);
    syncing = false;
  }

  @action
  void toggleSync() {
    syncing = !syncing;
    if (syncing) {
      sync();
    }
  }

  @action
  void send(String address, double amount) {
    compute(
        sendOne,
        SendMessage(databasePath, address, amount, spendingKey, sendParams, outputParams)
    );
  }
}

class SendMessage {
  String databasePath;
  String address;
  double amount;
  String spendingKey;
  ByteData sendParams;
  ByteData outputParams;

  SendMessage(this.databasePath, this.address, this.amount, this.spendingKey,
      this.sendParams, this.outputParams);
}

int syncOne(String databasePath) {
  int n = ZcApi.sync(databasePath, 200);
  return n;
}

void sendOne(SendMessage data) {
  ZcApi.send(data.databasePath, data.address, data.amount, data.spendingKey,
      data.sendParams, data.outputParams);
}

