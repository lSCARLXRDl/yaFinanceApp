import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_account.freezed.dart';
part 'bank_account.g.dart';

@freezed
abstract class BankAccount with _$BankAccount {
  const factory BankAccount({
    required int id,
    required int userid,
    required String name,
    required String balance,
    required String currency,
    required DateTime createdAt,
    required DateTime updatedAt
  }) = _BankAccount;

  factory BankAccount.fromJson(Map<String, Object?> json) => _$BankAccountFromJson(json);
}