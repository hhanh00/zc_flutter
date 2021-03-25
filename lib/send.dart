import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:zc_api/zc_api.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'main.dart';

class SendPage extends StatefulWidget {
  @override
  SendState createState() => SendState();
}

class SendState extends State<SendPage> {
  final _formKey = GlobalKey<FormState>();
  var _address = "";
  var _amount = 0.0;
  final _addressController = TextEditingController();
  final _currencyController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: TextFormField(
                  decoration: InputDecoration(labelText: 'Send ZEC to...'),
                  minLines: 4, maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _addressController,
                  validator: checkAddress,
                  ),
                ),
                IconButton(icon: new Icon(MdiIcons.qrcodeScan), onPressed: onScan)
              ]
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: _currencyController,
              validator: checkAmount,
              onSaved: onAmount
            ),
            ButtonBar(
              children: [
                IconButton(icon: new Icon(MdiIcons.send), onPressed: () { onSend(context); }),
                IconButton(icon: new Icon(MdiIcons.cancel), onPressed: () { onCancel(context); })
              ]
            )
          ]
        )
      )
    );
  }

  String checkAddress(String v) {
    if (v == null || v.isEmpty) return 'Address is empty';
    if (!ZcApi.checkAddress(v)) return 'Invalid Address';
    return null;
  }

  String checkAmount(String vs) {
    final v = double.tryParse(vs);
    if (v == null) return 'Amount must be a number';
    if (v <= 0.0) return 'Amount must be positive';
    if (v > appStore.balance) return 'Not enough balance';
    return null;
  }

  void onCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onScan() async {
    var code = await BarcodeScanner.scan();
    setState(() {
      _address = code.rawContent;
      _addressController.text = _address;
    });
  }

  void onAmount(v) {
    _amount = double.parse(v);
  }

  void onSend(BuildContext context) async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      final approved = await showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext context) =>
          AlertDialog(title: Text('Please Confirm'),
            content: SingleChildScrollView(
              child: Text("Sending $_amount ZEC to $_address")
            ),
            actions: <Widget>[
              TextButton(child: Text('Approve'), onPressed: () {Navigator.of(context).pop(true);}),
              TextButton(child: Text('Cancel'), onPressed: () {Navigator.of(context).pop(false);})
            ],
          )
      );
      if (approved) {
        final snackBar = SnackBar(
            content: Text("Sending $_amount ZEC to $_address"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        appStore.send(_address, _amount);
        Navigator.of(context).pop();
      }
    }
  }
}
