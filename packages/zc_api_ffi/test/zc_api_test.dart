import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zc_api/zc_api.dart';

void main() {
  const MethodChannel channel = MethodChannel('zc_api');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ZcApi.platformVersion, '42');
  });
}
