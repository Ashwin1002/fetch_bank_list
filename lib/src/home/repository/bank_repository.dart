import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../common/service/service.dart';
import '../../../common/utils/utils.dart';
import '../model/model.dart';

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
