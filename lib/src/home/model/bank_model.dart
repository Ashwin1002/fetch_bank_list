import 'package:freezed_annotation/freezed_annotation.dart';
part 'bank_model.freezed.dart';
part 'bank_model.g.dart';

@Freezed()
class BankModel with _$BankModel {
  const factory BankModel({
    required String idx,
    required String name,
    @Default('') String shortName,
    @Default('') String logo,
    @Default('') String swiftCode,
    required String address,
  }) = _BankModel;

  factory BankModel.fromJson(Map<String, dynamic> json)=> _$$_BankModelFromJson(json);
}
