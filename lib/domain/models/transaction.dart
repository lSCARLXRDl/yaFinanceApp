class Transaction {
  const Transaction({
    required this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.transactionDate,
    required this.comment,
    required this.createdAt,
    required this.updatedAt
  });

  final int id;
  final int accountId;
  final int categoryId;
  final String amount;
  final DateTime transactionDate;
  final String? comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  String toString() {
    return 'Category(id: $id, accountId: "$accountId",'
        ' categoryId: "$categoryId", amount: "$amount",'
        ' transactionDate: "$transactionDate", comment: "$comment",'
        ' createdAt: "$createdAt", updatedAt: "$updatedAt")';
  }

}