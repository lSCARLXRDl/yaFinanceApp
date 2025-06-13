class BankAccount {
  const BankAccount({
    required this.id,
    required this.userid,
    required this.name,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt
  });

  final int id;
  final int userid;
  final String name;
  final String balance;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;

  String toString() {
    return 'BankAccount(id: $id, userid: "$userid",'
        ' name: "$name", balance: "$balance",'
        ' currency: "$currency", createdAt: "$createdAt",'
        ' updatedAt: "$updatedAt")';
  }
}