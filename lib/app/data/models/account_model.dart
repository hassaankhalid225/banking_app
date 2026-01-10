class AccountModel {
  final String id;
  final String userId;
  final String accountNumber;
  final String accountType;
  final double balance;
  final String currency;
  final bool isPrimary;

  AccountModel({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.currency,
    required this.isPrimary,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      accountNumber: json['accountNumber'] as String,
      accountType: json['accountType'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      isPrimary: json['isPrimary'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'accountNumber': accountNumber,
      'accountType': accountType,
      'balance': balance,
      'currency': currency,
      'isPrimary': isPrimary,
    };
  }

  AccountModel copyWith({
    String? id,
    String? userId,
    String? accountNumber,
    String? accountType,
    double? balance,
    String? currency,
    bool? isPrimary,
  }) {
    return AccountModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountNumber: accountNumber ?? this.accountNumber,
      accountType: accountType ?? this.accountType,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}
