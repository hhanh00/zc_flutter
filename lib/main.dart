import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sqflite/sqflite.dart';
import 'account.dart';
import 'store.dart';

import 'send.dart';

var appStore = AppStore();

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> init() async {
    final sendParams = await rootBundle.load('assets/sapling-spend.params');
    final outputParams = await rootBundle.load('assets/sapling-output.params');
    await appStore.initialize(sendParams, outputParams);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: buildInternal);
  }

  Widget buildInternal(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (!snapshot.hasData)
      return CircularProgressIndicator();
    return MaterialApp(
      title: 'ZCash wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccountPage(),
      routes: {
        '/send': (context) => SendPage(),
      }
    );
  }
}
