// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BankModel _$BankModelFromJson(Map<String, dynamic> json) {
  return _BankModel.fromJson(json);
}

/// @nodoc
mixin _$BankModel {
  String get idx => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get shortName => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;
  String get swiftCode => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BankModelCopyWith<BankModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankModelCopyWith<$Res> {
  factory $BankModelCopyWith(BankModel value, $Res Function(BankModel) then) =
      _$BankModelCopyWithImpl<$Res, BankModel>;
  @useResult
  $Res call(
      {String idx,
      String name,
      String shortName,
      String logo,
      String swiftCode,
      String address});
}

/// @nodoc
class _$BankModelCopyWithImpl<$Res, $Val extends BankModel>
    implements $BankModelCopyWith<$Res> {
  _$BankModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? name = null,
    Object? shortName = null,
    Object? logo = null,
    Object? swiftCode = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      swiftCode: null == swiftCode
          ? _value.swiftCode
          : swiftCode // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BankModelCopyWith<$Res> implements $BankModelCopyWith<$Res> {
  factory _$$_BankModelCopyWith(
          _$_BankModel value, $Res Function(_$_BankModel) then) =
      __$$_BankModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String idx,
      String name,
      String shortName,
      String logo,
      String swiftCode,
      String address});
}

/// @nodoc
class __$$_BankModelCopyWithImpl<$Res>
    extends _$BankModelCopyWithImpl<$Res, _$_BankModel>
    implements _$$_BankModelCopyWith<$Res> {
  __$$_BankModelCopyWithImpl(
      _$_BankModel _value, $Res Function(_$_BankModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? name = null,
    Object? shortName = null,
    Object? logo = null,
    Object? swiftCode = null,
    Object? address = null,
  }) {
    return _then(_$_BankModel(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      swiftCode: null == swiftCode
          ? _value.swiftCode
          : swiftCode // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BankModel implements _BankModel {
  const _$_BankModel(
      {required this.idx,
      required this.name,
      this.shortName = '',
      this.logo = '',
      this.swiftCode = '',
      required this.address});

  factory _$_BankModel.fromJson(Map<String, dynamic> json) =>
      _$$_BankModelFromJson(json);

  @override
  final String idx;
  @override
  final String name;
  @override
  @JsonKey()
  final String shortName;
  @override
  @JsonKey()
  final String logo;
  @override
  @JsonKey()
  final String swiftCode;
  @override
  final String address;

  @override
  String toString() {
    return 'BankModel(idx: $idx, name: $name, shortName: $shortName, logo: $logo, swiftCode: $swiftCode, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BankModel &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.swiftCode, swiftCode) ||
                other.swiftCode == swiftCode) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idx, name, shortName, logo, swiftCode, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BankModelCopyWith<_$_BankModel> get copyWith =>
      __$$_BankModelCopyWithImpl<_$_BankModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BankModelToJson(
      this,
    );
  }
}

abstract class _BankModel implements BankModel {
  const factory _BankModel(
      {required final String idx,
      required final String name,
      final String shortName,
      final String logo,
      final String swiftCode,
      required final String address}) = _$_BankModel;

  factory _BankModel.fromJson(Map<String, dynamic> json) =
      _$_BankModel.fromJson;

  @override
  String get idx;
  @override
  String get name;
  @override
  String get shortName;
  @override
  String get logo;
  @override
  String get swiftCode;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_BankModelCopyWith<_$_BankModel> get copyWith =>
      throw _privateConstructorUsedError;
}
