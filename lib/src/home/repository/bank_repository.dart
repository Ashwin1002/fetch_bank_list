import 'dart:developer';
import 'package:assign_khalti/common/service/network/base_client.dart';
import 'package:assign_khalti/src/home/model/bank_model.dart';
import 'package:http/http.dart' as http;
import '../../../common/service/sqflite/bank_db_helper.dart';
import '../../../common/utils/cache_data_utils.dart';

final BaseClient _baseClient = BaseClient();

class BankRepository {
  Future<List<BankModel>?> getBankList({
    bool cacheExpired = true,
    String? deviceModel,
  }) async {
    List<BankModel> dataList = [];
    if (cacheExpired) {
      log("from server");
      final response = await _baseClient.getResponse(
        baseHttp: http.Client(),
        endPoint: "bank",
        deviceModel: deviceModel ?? "",
      );
      if (response case final response?) {
        await BankDBHelper.instance.deleteAllData();
        await DataCacheService.setCacheData();

        var tempList = (response['records'] as List)
            .map<BankModel>((e) => BankModel.fromJson(e))
            .toList();

        for (var element in tempList) {
          await BankDBHelper.instance.insertData(element);
        }
        dataList = tempList;
      } else {
        dataList = [];
      }
    } else {
      dataList = await DataCacheService.getCachedData();
      log("from cached data $dataList");
    }
    return dataList;
  }
}
