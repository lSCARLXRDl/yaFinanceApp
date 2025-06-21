// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountResponseDto {

 int get id; String get name; String get balance; String get currency; StatItemDto get incomeStats; StatItemDto get expenseStats; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of AccountResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountResponseDtoCopyWith<AccountResponseDto> get copyWith => _$AccountResponseDtoCopyWithImpl<AccountResponseDto>(this as AccountResponseDto, _$identity);

  /// Serializes this AccountResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.incomeStats, incomeStats) || other.incomeStats == incomeStats)&&(identical(other.expenseStats, expenseStats) || other.expenseStats == expenseStats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,balance,currency,incomeStats,expenseStats,createdAt,updatedAt);

@override
String toString() {
  return 'AccountResponseDto(id: $id, name: $name, balance: $balance, currency: $currency, incomeStats: $incomeStats, expenseStats: $expenseStats, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AccountResponseDtoCopyWith<$Res>  {
  factory $AccountResponseDtoCopyWith(AccountResponseDto value, $Res Function(AccountResponseDto) _then) = _$AccountResponseDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String balance, String currency, StatItemDto incomeStats, StatItemDto expenseStats, DateTime createdAt, DateTime updatedAt
});


$StatItemDtoCopyWith<$Res> get incomeStats;$StatItemDtoCopyWith<$Res> get expenseStats;

}
/// @nodoc
class _$AccountResponseDtoCopyWithImpl<$Res>
    implements $AccountResponseDtoCopyWith<$Res> {
  _$AccountResponseDtoCopyWithImpl(this._self, this._then);

  final AccountResponseDto _self;
  final $Res Function(AccountResponseDto) _then;

/// Create a copy of AccountResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? balance = null,Object? currency = null,Object? incomeStats = null,Object? expenseStats = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,incomeStats: null == incomeStats ? _self.incomeStats : incomeStats // ignore: cast_nullable_to_non_nullable
as StatItemDto,expenseStats: null == expenseStats ? _self.expenseStats : expenseStats // ignore: cast_nullable_to_non_nullable
as StatItemDto,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of AccountResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatItemDtoCopyWith<$Res> get incomeStats {
  
  return $StatItemDtoCopyWith<$Res>(_self.incomeStats, (value) {
    return _then(_self.copyWith(incomeStats: value));
  });
}/// Create a copy of AccountResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatItemDtoCopyWith<$Res> get expenseStats {
  
  return $StatItemDtoCopyWith<$Res>(_self.expenseStats, (value) {
    return _then(_self.copyWith(expenseStats: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _AccountResponseDto implements AccountResponseDto {
  const _AccountResponseDto({required this.id, required this.name, required this.balance, required this.currency, required this.incomeStats, required this.expenseStats, required this.createdAt, required this.updatedAt});
  factory _AccountResponseDto.fromJson(Map<String, dynamic> json) => _$AccountResponseDtoFromJson(json);

@override final  int id;
@override final  String name;
@override final  String balance;
@override final  String currency;
@override final  StatItemDto incomeStats;
@override final  StatItemDto expenseStats;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of AccountResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountResponseDtoCopyWith<_AccountResponseDto> get copyWith => __$AccountResponseDtoCopyWithImpl<_AccountResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.incomeStats, incomeStats) || other.incomeStats == incomeStats)&&(identical(other.expenseStats, expenseStats) || other.expenseStats == expenseStats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,balance,currency,incomeStats,expenseStats,createdAt,updatedAt);

@override
String toString() {
  return 'AccountResponseDto(id: $id, name: $name, balance: $balance, currency: $currency, incomeStats: $incomeStats, expenseStats: $expenseStats, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AccountResponseDtoCopyWith<$Res> implements $AccountResponseDtoCopyWith<$Res> {
  factory _$AccountResponseDtoCopyWith(_AccountResponseDto value, $Res Function(_AccountResponseDto) _then) = __$AccountResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String balance, String currency, StatItemDto incomeStats, StatItemDto expenseStats, DateTime createdAt, DateTime updatedAt
});


@override $StatItemDtoCopyWith<$Res> get incomeStats;@override $StatItemDtoCopyWith<$Res> get expenseStats;

}
/// @nodoc
class __$AccountResponseDtoCopyWithImpl<$Res>
    implements _$AccountResponseDtoCopyWith<$Res> {
  __$AccountResponseDtoCopyWithImpl(this._self, this._then);

  final _AccountResponseDto _self;
  final $Res Function(_AccountResponseDto) _then;

/// Create a copy of AccountResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? balance = null,Object? currency = null,Object? incomeStats = null,Object? expenseStats = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_AccountResponseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,incomeStats: null == incomeStats ? _self.incomeStats : incomeStats // ignore: cast_nullable_to_non_nullable
as StatItemDto,expenseStats: null == expenseStats ? _self.expenseStats : expenseStats // ignore: cast_nullable_to_non_nullable
as StatItemDto,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of AccountResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatItemDtoCopyWith<$Res> get incomeStats {
  
  return $StatItemDtoCopyWith<$Res>(_self.incomeStats, (value) {
    return _then(_self.copyWith(incomeStats: value));
  });
}/// Create a copy of AccountResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatItemDtoCopyWith<$Res> get expenseStats {
  
  return $StatItemDtoCopyWith<$Res>(_self.expenseStats, (value) {
    return _then(_self.copyWith(expenseStats: value));
  });
}
}

// dart format on
