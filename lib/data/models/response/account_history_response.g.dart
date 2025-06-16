// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountHistoryResponseDto _$AccountHistoryResponseDtoFromJson(
  Map<String, dynamic> json,
) => _AccountHistoryResponseDto(
  accountId: (json['accountId'] as num).toInt(),
  accountName: json['accountName'] as String,
  currency: json['currency'] as String,
  currentBalance: json['currentBalance'] as String,
  history: AccountHistoryDto.fromJson(json['history'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountHistoryResponseDtoToJson(
  _AccountHistoryResponseDto instance,
) => <String, dynamic>{
  'accountId': instance.accountId,
  'accountName': instance.accountName,
  'currency': instance.currency,
  'currentBalance': instance.currentBalance,
  'history': instance.history,
};
