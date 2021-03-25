import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'main.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZCash'),
        actions: <Widget>[
          Observer(
            builder: (context) => IconButton(
              icon: _sync(context, appStore.syncing),
              onPressed: () => appStore.toggleSync(),
            ),
          )
        ]
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Observer(
          builder: (context) =>
            Column(
                children: <Widget>[
                  QrImage(data: appStore.address, size: 200,),
                  SelectableText(appStore.address, style: Theme.of(context).textTheme.bodyText1),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  Text(appStore.balance.toStringAsFixed(4), style: Theme.of(context).textTheme.headline2),
              ]
            )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/send');
        },
        child: Icon(Icons.send),
      )
    );
  }

  _sync(BuildContext context, bool syncing) {
    if (syncing)
      return Icon(Icons.stop, color: Colors.white);
    else
      return Icon(Icons.refresh, color: Colors.white);
  }
}