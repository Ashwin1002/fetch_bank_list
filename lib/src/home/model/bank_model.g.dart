// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BankModel _$$_BankModelFromJson(Map<String, dynamic> json) => _$_BankModel(
      idx: json['idx'] as String,
      name: json['name'] as String,
      shortName: json['short_name'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      swiftCode: json['swift_code'] as String? ?? '',
      address: json['address'] as String,
    );

Map<String, dynamic> _$$_BankModelToJson(_$_BankModel instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'name': instance.name,
      'shortName': instance.shortName,
      'logo': instance.logo,
      'swiftCode': instance.swiftCode,
      'address': instance.address,
    };
