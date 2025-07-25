import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_finance_app/data/api/api_client.dart';
import 'package:ya_finance_app/data/api/iapi_client.dart';
import 'package:ya_finance_app/data/models/request/account_create_request.dart';
import 'package:ya_finance_app/data/models/shared/account.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_repository_impl.dart';

class MockAccountRepository extends Mock implements BankAccountRepositoryImpl {}

class MockApiClient extends Mock implements IApiClient {}

Future<void> main() async {
  late BankAccountRepositoryImpl repository;
  late MockApiClient apiClientMock;

  setUpAll(() async {
    apiClientMock = MockApiClient();
    repository = BankAccountRepositoryImpl(apiClientMock);
  });

  group('BankAccountRepositoryImpl', () {
    test('successful creation returns BankAccount', () async {
      // Arrange
      final request = AccountCreateRequestDto(
          name: 'Test Account',
          balance: '100.00',
          currency: 'USD'
      );
      final mockResponse = AccountDto(
        id: 10,
        userId: 1,
        name: 'Test Account',
        balance: '100.00',
        currency: 'USD',
        createdAt: DateTime(2022, 1, 1),
        updatedAt: DateTime(2022, 1, 2),
      );

      registerFallbackValue(<String, dynamic>{});
      when(() => apiClientMock.post('/accounts', data: request.toJson()))
          .thenAnswer((_) async => mockResponse);

      final result = await repository.createBankAccount(request: request);

      expect(result.name, 'Test Account');
      expect(result.balance, '100.00');
      verify(() => apiClientMock.post('/accounts', data: request.toJson())).called(1);
    });
  });
}