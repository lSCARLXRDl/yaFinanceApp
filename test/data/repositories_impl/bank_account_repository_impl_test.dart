import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_finance_app/data/api/api_client.dart';
import 'package:ya_finance_app/data/models/request/account_create_request.dart';
import 'package:ya_finance_app/data/models/request/account_update_request.dart';
import 'package:ya_finance_app/data/models/shared/account.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_repository_impl.dart';

class MockAccountRepository extends Mock implements BankAccountRepositoryImpl {}
class MockApiClient extends Mock implements ApiClient {}

Future<void> main() async {
  late BankAccountRepositoryImpl repository;
  late MockApiClient apiClientMock;

  setUpAll(() async {
    apiClientMock = MockApiClient();
    repository = BankAccountRepositoryImpl(apiClientMock);
  });

  group('BankAccountRepositoryImpl', () {

    test('successful creation returns BankAccount with the necessary parameters', () async {

      final request = AccountCreateRequestDto(name: 'Test Account', balance: '100.00', currency: 'USD');
      final mockResponse = AccountDto(
        id: 149,
        userId: 1,
        name: 'Test Account',
        balance: '100.00',
        currency: 'USD',
        createdAt: DateTime(2022, 1, 1),
        updatedAt: DateTime(2022, 1, 2),
      );

      when(() => apiClientMock.post('accounts', data: request.toJson())).thenAnswer((_) async => mockResponse.toJson());

      final result = await repository.createBankAccount(request: request);

      expect(result.name, mockResponse.name);
      expect(result.balance, mockResponse.balance);
      expect(result.currency, mockResponse.currency);
      verify(() => apiClientMock.post('accounts', data: request.toJson())).called(1);
    });

    test('successful get BankAccounts with the necessary parameters', () async {
      final mockResponse = [AccountDto(
        id: 149,
        userId: 1,
        name: 'Test Account',
        balance: '100.00',
        currency: 'USD',
        createdAt: DateTime(2022, 1, 1),
        updatedAt: DateTime(2022, 1, 2),
      )];
      when(() => apiClientMock.get('accounts'))
          .thenAnswer((_) async => mockResponse.map((el) => el.toJson()).toList());

      final result = await repository.getBankAccounts();
      expect(result, hasLength(1));
      final acc = result.first;
      expect(acc.id, mockResponse[0].id);
      expect(acc.userid, mockResponse[0].userId);
      expect(acc.name, mockResponse[0].name);
      expect(acc.balance, mockResponse[0].balance);
      expect(acc.currency, mockResponse[0].currency);
      expect(acc.createdAt, mockResponse[0].createdAt);
      expect(acc.updatedAt, mockResponse[0].updatedAt);
      verify(() => apiClientMock.get('accounts')).called(1);
    });

    test('successful get BankAccount by id with the necessary parameters', () async {
      final mockResponse = [AccountDto(
        id: 149,
        userId: 1,
        name: 'Test Account',
        balance: '100.00',
        currency: 'USD',
        createdAt: DateTime(2022, 1, 1),
        updatedAt: DateTime(2022, 1, 2),
      )];

      when(() => apiClientMock.get('accounts')).thenAnswer((_) async => mockResponse.map((el) => el.toJson()).toList());

      final result = await repository.getBankAccountById(id: 149);
      expect(result.id, mockResponse[0].id);
      expect(result.userid, mockResponse[0].userId);
      expect(result.name, mockResponse[0].name);
      expect(result.balance, mockResponse[0].balance);
      expect(result.currency, mockResponse[0].currency);
      expect(result.createdAt, mockResponse[0].createdAt);
      expect(result.updatedAt, mockResponse[0].updatedAt);
      verify(() => apiClientMock.get('accounts')).called(1);
    });

    test('successful update returns BankAccount with the necessary parameters', () async {
      final request = AccountUpdateRequestDto(name: 'New Test Account', balance: '150.00', currency: 'USD');
      final mockResponse = AccountDto(
        id: 149,
        userId: 1,
        name: 'New Test Account',
        balance: '150.00',
        currency: 'USD',
        createdAt: DateTime(2022, 1, 1),
        updatedAt: DateTime(2022, 1, 2),
      );

      when(() => apiClientMock.put('accounts/149', data: request.toJson())).thenAnswer((_) async => mockResponse.toJson());

      final result = await repository.updateBankAccount(id: 149, request: request);

      expect(result.name, mockResponse.name);
      expect(result.balance, mockResponse.balance);
      expect(result.currency, mockResponse.currency);
      verify(() => apiClientMock.put('accounts/149', data: request.toJson())).called(1);
    });

    test('successful delete BankAccount by id', () async {
      final mockResponse = true;

      when(() => apiClientMock.delete('accounts/149')).thenAnswer((_) async => mockResponse);

      final result = await repository.deleteBankAccount(id: 149);
      expect(result, true);
      verify(() => apiClientMock.delete('accounts/149')).called(1);
    });

    test('successful get AccountHistory by id with the necessary parameters', () async {
      final mockAccountStatePrev = {
        'id': 149,
        'name': 'Test Account',
        'balance': '81000.00',
        'currency': 'USD'
      };
      final mockAccountStateNew = {
        'id': 149,
        'name': 'Test Account',
        'balance': '82000.00',
        'currency': 'USD'
      };
      final mockAccountHistory = {
        'id': 1,
        'accountId': 149,
        'changeType': 'MODIFICATION',
        'previousState': mockAccountStatePrev,
        'newState': mockAccountStateNew,
        'changeTimestamp': '2022-01-01T00:00:00.000',
        'createdAt': '2022-01-02T00:00:00.000'
      };
      final mockResponse = {
        'accountId': 149,
        'accountName': 'Test Account',
        'currency': 'USD',
        'currentBalance': '81000.00',
        'history': mockAccountHistory
      };

      when(() => apiClientMock.get('accounts/149/history')).thenAnswer((_) async => mockResponse);

      final result = await repository.getHistoryBankAccount(id: 149);

      expect(result.accountId, mockResponse['accountId']);
      expect(result.accountName, mockResponse['accountName']);
      expect(result.currency, mockResponse['currency']);
      expect(result.currentBalance, mockResponse['currentBalance']);

      expect(result.history.id, mockAccountHistory['id']);
      expect(result.history.accountId, mockAccountHistory['accountId']);
      expect(result.history.changeType.name, mockAccountHistory['changeType']);
      expect(result.history.changeTimestamp.toIso8601String(), mockAccountHistory['changeTimestamp']);
      expect(result.history.createdAt.toIso8601String(), mockAccountHistory['createdAt']);

      expect(result.history.previousState.id, mockAccountStatePrev['id']);
      expect(result.history.previousState.name, mockAccountStatePrev['name']);
      expect(result.history.previousState.balance, mockAccountStatePrev['balance']);
      expect(result.history.previousState.currency, mockAccountStatePrev['currency']);

      expect(result.history.newState.id, mockAccountStateNew['id']);
      expect(result.history.newState.name, mockAccountStateNew['name']);
      expect(result.history.newState.balance, mockAccountStateNew['balance']);
      expect(result.history.newState.currency, mockAccountStateNew['currency']);

      verify(() => apiClientMock.get('accounts/149/history')).called(1);
    });

  });
}