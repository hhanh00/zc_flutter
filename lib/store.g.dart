// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$balanceAtom = Atom(name: '_AppStore.balance');

  @override
  double get balance {
    _$balanceAtom.reportRead();
    return super.balance;
  }

  @override
  set balance(double value) {
    _$balanceAtom.reportWrite(value, super.balance, () {
      super.balance = value;
    });
  }

  final _$phraseAtom = Atom(name: '_AppStore.phrase');

  @override
  String get phrase {
    _$phraseAtom.reportRead();
    return super.phrase;
  }

  @override
  set phrase(String value) {
    _$phraseAtom.reportWrite(value, super.phrase, () {
      super.phrase = value;
    });
  }

  final _$spendingKeyAtom = Atom(name: '_AppStore.spendingKey');

  @override
  String get spendingKey {
    _$spendingKeyAtom.reportRead();
    return super.spendingKey;
  }

  @override
  set spendingKey(String value) {
    _$spendingKeyAtom.reportWrite(value, super.spendingKey, () {
      super.spendingKey = value;
    });
  }

  final _$addressAtom = Atom(name: '_AppStore.address');

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  final _$syncingAtom = Atom(name: '_AppStore.syncing');

  @override
  bool get syncing {
    _$syncingAtom.reportRead();
    return super.syncing;
  }

  @override
  set syncing(bool value) {
    _$syncingAtom.reportWrite(value, super.syncing, () {
      super.syncing = value;
    });
  }

  final _$syncAsyncAction = AsyncAction('_AppStore.sync');

  @override
  Future<void> sync() {
    return _$syncAsyncAction.run(() => super.sync());
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void toggleSync() {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.toggleSync');
    try {
      return super.toggleSync();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void send(String address, double amount) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.send');
    try {
      return super.send(address, amount);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
balance: ${balance},
phrase: ${phrase},
spendingKey: ${spendingKey},
address: ${address},
syncing: ${syncing}
    ''';
  }
}
