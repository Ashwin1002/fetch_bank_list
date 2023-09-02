import 'dart:convert';
import 'package:assign_khalti/common/constant/constant_text.dart';
import 'package:assign_khalti/common/service/network/base_client.dart';
import 'package:assign_khalti/src/home/model/bank_model.dart';
import 'package:flutter_test/flutter_test.dart';
// file which has the getNumberTrivia function
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });
  group('getBankList', () {
    test('returns bank name when http response is successful', () async {
      // Mock the API call to return a json response with http status 200 Ok //
      final mockHTTPClient = MockClient((request) async {
        // Create sample response of the HTTP call //
        final Map<String, dynamic> response = {
          "name": " NIC ASIA Bank Limited",
          "short_name": "NIC Asia",
          "logo":
              "https://khalti-static.s3.ap-south-1.amazonaws.com/media/bank-logo/nic-asia.png",
          "swift_code": "NICENPKA",
          "address": "Thapathali, Kathmandu"
        };
        return http.Response(jsonEncode(response), 200);
      });
      // Check whether htttp response function returns
      // bank detail as map of <String, dynamic>
      expect(await BaseClient().getResponse(baseHttp: mockHTTPClient),
          isA<Map<String, dynamic>>());
    });

    test('return error message when http response is unsuccessful', () async {
      // Mock the API call to return an
      // empty json response with http status 404
      final mockHTTPClient = MockClient((request) async {
        final response = {};
        return http.Response(jsonEncode(response), 609);
      });
      // Check whether htttp response function returns
      // error as String,
      expect(await BaseClient().getResponse(baseHttp: mockHTTPClient),
          "Data not Found.");
    });
  });

  test('Cached Share Preference Data Test', () async {
    //set values here
    SharedPreferences.setMockInitialValues({
      ConstantText.cachedTimeInSec: 1000,
      ConstantText.isCacheExpired: true,
      ConstantText.showDeviceName: 'Iphone',
    });

    SharedPreferences pref = await SharedPreferences.getInstance();

    expect(pref.getBool(ConstantText.isCacheExpired), true);
    expect(pref.getString(ConstantText.showDeviceName), 'Iphone');
    expect(pref.getInt(ConstantText.cachedTimeInSec), 1000);
  });

  // Setup sqflite_common_ffi for flutter test
  test('Caching Banking List Test Using SQFLite Database', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE ${DBConstant.bankListTable} (id INTEGER PRIMARY KEY, ${DBConstant.idx} TEXT, ${DBConstant.bankName} TEXT,  ${DBConstant.shortName} TEXT, ${DBConstant.logo} TEXT, ${DBConstant.swiftCode} TEXT, ${DBConstant.address} TEXT)');
    });
    // Insert some data
    await db.insert(DBConstant.bankListTable, {
      "idx": "UZmPqTDkdhKmukdZe2gVWZ",
      "name": "Agricultural Development Bank Limited",
      "short_name": "ADBL",
      "logo":
          "https://khalti-static.s3.ap-south-1.amazonaws.com/media/bank-logo/adbl.png",
      "swift_code": "ADBLNPKA",
      "address": "Singhadurbar, Kathmandu"
    });
    // Check content
    expect(await db.query(DBConstant.bankListTable), [
      {
        'id': 1,
        'idx': 'UZmPqTDkdhKmukdZe2gVWZ',
        'name': 'Agricultural Development Bank Limited',
        'short_name': 'ADBL',
        'logo':
            'https://khalti-static.s3.ap-south-1.amazonaws.com/media/bank-logo/adbl.png',
        'swift_code': 'ADBLNPKA',
        'address': 'Singhadurbar, Kathmandu'
      }
    ]);

    await db.close();
  });

  test('Search Bank Data By Name or Swift Code Test', () async {
    //set values here
    final List<BankModel> fakeBankList = [
      const BankModel(
        idx: "qwerty",
        name: 'Example Bank',
        address: 'Ktm, Nepal',
        swiftCode: 'EX1B',
        logo: '',
        shortName: 'E-Bank',
      ),
      const BankModel(
        idx: "asdfgh",
        name: 'Example 2 Bank',
        address: 'Pkr, Nepal',
        swiftCode: 'EX2B',
        logo: '',
        shortName: 'E2-Bank',
      ),
    ];

    List<BankModel> tempBankList = fakeBankList;

    tempBankList = fakeBankList
        .where(
            (e) => (e.swiftCode.toLowerCase().contains('EX1B'.toLowerCase())))
        .toList();

    expect([
      const BankModel(
        idx: "qwerty",
        name: 'Example Bank',
        address: 'Ktm, Nepal',
        swiftCode: 'EX1B',
        logo: '',
        shortName: 'E-Bank',
      ),
    ], tempBankList);
  });
}
