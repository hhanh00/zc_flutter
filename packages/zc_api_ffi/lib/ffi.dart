/// bindings for `libzc_api_ffi`

import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart' as ffi;

// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names
final DynamicLibrary _dl = _open();
/// Reference to the Dynamic Library, it should be only used for low-level access
final DynamicLibrary dl = _dl;
DynamicLibrary _open() {
  if (Platform.isAndroid) return DynamicLibrary.open('libzc_api_ffi.so');
  if (Platform.isIOS) return DynamicLibrary.executable();
  throw UnsupportedError('This platform is not supported.');
}

/// C struct `CKeys`.
class CKeys extends Struct {
  
  Pointer<ffi.Utf8> phrase;
  Pointer<ffi.Utf8> derivation_path;
  Pointer<ffi.Utf8> spending_key;
  Pointer<ffi.Utf8> viewing_key;
  Pointer<ffi.Utf8> address;
  static Pointer<CKeys> allocate() {
    return ffi.allocate<CKeys>();
  }


  static CKeys from(int ptr) {
    return Pointer<CKeys>.fromAddress(ptr).ref;
  }

}

/// C function `check_address`.
int check_address(
  Pointer<ffi.Utf8> address,
) {
  return _check_address(address);
}
final _check_address_Dart _check_address = _dl.lookupFunction<_check_address_C, _check_address_Dart>('check_address');
typedef _check_address_C = Int32 Function(
  Pointer<ffi.Utf8> address,
);
typedef _check_address_Dart = int Function(
  Pointer<ffi.Utf8> address,
);

/// C function `get_balance`.
int get_balance(
  Pointer<ffi.Utf8> database_path,
) {
  return _get_balance(database_path);
}
final _get_balance_Dart _get_balance = _dl.lookupFunction<_get_balance_C, _get_balance_Dart>('get_balance');
typedef _get_balance_C = Uint64 Function(
  Pointer<ffi.Utf8> database_path,
);
typedef _get_balance_Dart = int Function(
  Pointer<ffi.Utf8> database_path,
);

/// C function `init_account`.
CKeys init_account(
  Pointer<ffi.Utf8> database_path,
) {
  return _init_account(database_path);
}
final _init_account_Dart _init_account = _dl.lookupFunction<_init_account_C, _init_account_Dart>('init_account');
typedef _init_account_C = CKeys Function(
  Pointer<ffi.Utf8> database_path,
);
typedef _init_account_Dart = CKeys Function(
  Pointer<ffi.Utf8> database_path,
);

/// C function `initialize`.
int initialize(
  Pointer<ffi.Utf8> database_path,
) {
  return _initialize(database_path);
}
final _initialize_Dart _initialize = _dl.lookupFunction<_initialize_C, _initialize_Dart>('initialize');
typedef _initialize_C = Int32 Function(
  Pointer<ffi.Utf8> database_path,
);
typedef _initialize_Dart = int Function(
  Pointer<ffi.Utf8> database_path,
);

/// C function `send_tx`.
void send_tx(
  Pointer<ffi.Utf8> database_path,
  Pointer<ffi.Utf8> address,
  int amount,
  Pointer<ffi.Utf8> spending_key,
  Pointer<ffi.Utf8> spend_params,
  int len_spend_params,
  Pointer<ffi.Utf8> output_params,
  int len_output_params,
) {
  _send_tx(database_path, address, amount, spending_key, spend_params, len_spend_params, output_params, len_output_params);
}
final _send_tx_Dart _send_tx = _dl.lookupFunction<_send_tx_C, _send_tx_Dart>('send_tx');
typedef _send_tx_C = Void Function(
  Pointer<ffi.Utf8> database_path,
  Pointer<ffi.Utf8> address,
  Uint64 amount,
  Pointer<ffi.Utf8> spending_key,
  Pointer<ffi.Utf8> spend_params,
  Uint64 len_spend_params,
  Pointer<ffi.Utf8> output_params,
  Uint64 len_output_params,
);
typedef _send_tx_Dart = void Function(
  Pointer<ffi.Utf8> database_path,
  Pointer<ffi.Utf8> address,
  int amount,
  Pointer<ffi.Utf8> spending_key,
  Pointer<ffi.Utf8> spend_params,
  int len_spend_params,
  Pointer<ffi.Utf8> output_params,
  int len_output_params,
);

/// C function `sync`.
int sync(
  Pointer<ffi.Utf8> database_path,
  int max_blocks,
) {
  return _sync(database_path, max_blocks);
}
final _sync_Dart _sync = _dl.lookupFunction<_sync_C, _sync_Dart>('sync');
typedef _sync_C = Uint64 Function(
  Pointer<ffi.Utf8> database_path,
  Uint32 max_blocks,
);
typedef _sync_Dart = int Function(
  Pointer<ffi.Utf8> database_path,
  int max_blocks,
);
