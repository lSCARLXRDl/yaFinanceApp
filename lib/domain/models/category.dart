class Category {
  const Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.isIncome
  });

  final int id;
  final String name;
  final String emoji;
  final bool isIncome;

  String toString() {
    return 'Category(id: $id, name: "$name", emoji: "$emoji", isIncome: $isIncome)';
  }

}