import 'dart:developer';
import 'package:assign_khalti/common/service/network/exceptions/app_exception.dart';
import 'package:assign_khalti/common/service/sqflite/bank_db_helper.dart';
import 'package:assign_khalti/common/utils/shared_pref.dart';

import '../../src/home/model/bank_model.dart';
import '../constant/constant_text.dart';

class DataCacheService {
  // Function to cache data for an hour.
  static Future<void> setCacheData() async {
    // Store the data along with a timestamp.
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    await SharePref.setData(
        key: ConstantText.cachedTimeInSec, dValue: timestamp, type: 'int');

    await SharePref.setData(
        key: ConstantText.isCacheExpired, dValue: false, type: 'bool');
  }

  // Function to retrieve cached data if it's less than an hour old.
  static Future<List<BankModel>> getCachedData() async {
    final timestamp = await SharePref.getData(
        key: ConstantText.cachedTimeInSec, type: 'int', dValue: 0);

    List<BankModel> bankList = [];

    if (timestamp != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (currentTime - timestamp < 3600000) {
        bankList = await BankDBHelper.instance.getDataList();
        log("with in hour");
      } else {
        log("expired");
        await SharePref.setData(
            key: ConstantText.isCacheExpired, type: 'bool', dValue: true);
        await SharePref.removeData(
            key: ConstantText.cachedTimeInSec, type: 'int');
        await BankDBHelper.instance.deleteAllData();
        bankList = [];
        throw FetchDataException(
          "Session Expired.\n Please Connect to the internet and try again",
          "NaN",
        );
      }
    } else {
      bankList = [];
    }
    return bankList;
  }
}
