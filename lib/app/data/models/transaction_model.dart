class TransactionModel {
  final String id;
  final String accountId;
  final String type; // debit, credit, transfer
  final String category;
  final double amount;
  final String description;
  final String recipientName;
  final String recipientAvatar;
  final DateTime timestamp;
  final String status;

  TransactionModel({
    required this.id,
    required this.accountId,
    required this.type,
    required this.category,
    required this.amount,
    required this.description,
    required this.recipientName,
    required this.recipientAvatar,
    required this.timestamp,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      recipientName: json['recipientName'] as String,
      recipientAvatar: json['recipientAvatar'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'type': type,
      'category': category,
      'amount': amount,
      'description': description,
      'recipientName': recipientName,
      'recipientAvatar': recipientAvatar,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }

  bool get isCredit => type == 'credit';
  bool get isDebit => type == 'debit';
  bool get isTransfer => type == 'transfer';

  String get formattedAmount {
    final sign = isCredit ? '+' : '-';
    return '$sign\$${amount.toStringAsFixed(2)}';
  }

  TransactionModel copyWith({
    String? id,
    String? accountId,
    String? type,
    String? category,
    double? amount,
    String? description,
    String? recipientName,
    String? recipientAvatar,
    DateTime? timestamp,
    String? status,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      recipientName: recipientName ?? this.recipientName,
      recipientAvatar: recipientAvatar ?? this.recipientAvatar,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }
}
