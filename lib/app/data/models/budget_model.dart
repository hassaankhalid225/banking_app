class BudgetModel {
  final String id;
  final String userId;
  final String category;
  final double budgetAmount;
  final double spentAmount;
  final String period; // weekly, monthly
  final DateTime startDate;
  final DateTime endDate;

  BudgetModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.budgetAmount,
    required this.spentAmount,
    required this.period,
    required this.startDate,
    required this.endDate,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      category: json['category'] as String,
      budgetAmount: (json['budgetAmount'] as num).toDouble(),
      spentAmount: (json['spentAmount'] as num).toDouble(),
      period: json['period'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'category': category,
      'budgetAmount': budgetAmount,
      'spentAmount': spentAmount,
      'period': period,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  double get remainingAmount => budgetAmount - spentAmount;
  double get percentageUsed => (spentAmount / budgetAmount) * 100;
  bool get isOverBudget => spentAmount > budgetAmount;

  BudgetModel copyWith({
    String? id,
    String? userId,
    String? category,
    double? budgetAmount,
    double? spentAmount,
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      budgetAmount: budgetAmount ?? this.budgetAmount,
      spentAmount: spentAmount ?? this.spentAmount,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
