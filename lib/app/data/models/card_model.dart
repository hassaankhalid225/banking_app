class CardModel {
  final String id;
  final String accountId;
  final String cardNumber;
  final String cardType; // VISA, Mastercard
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final bool isActive;
  final bool isFrozen;
  final double cardLimit;

  CardModel({
    required this.id,
    required this.accountId,
    required this.cardNumber,
    required this.cardType,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.isActive,
    required this.isFrozen,
    required this.cardLimit,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      cardNumber: json['cardNumber'] as String,
      cardType: json['cardType'] as String,
      cardHolderName: json['cardHolderName'] as String,
      expiryDate: json['expiryDate'] as String,
      cvv: json['cvv'] as String,
      isActive: json['isActive'] as bool,
      isFrozen: json['isFrozen'] as bool,
      cardLimit: (json['cardLimit'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'cardNumber': cardNumber,
      'cardType': cardType,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'isActive': isActive,
      'isFrozen': isFrozen,
      'cardLimit': cardLimit,
    };
  }

  String get maskedCardNumber {
    if (cardNumber.length < 4) return cardNumber;
    return '•••• •••• •••• ${cardNumber.substring(cardNumber.length - 4)}';
  }

  CardModel copyWith({
    String? id,
    String? accountId,
    String? cardNumber,
    String? cardType,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    bool? isActive,
    bool? isFrozen,
    double? cardLimit,
  }) {
    return CardModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      cardNumber: cardNumber ?? this.cardNumber,
      cardType: cardType ?? this.cardType,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isActive: isActive ?? this.isActive,
      isFrozen: isFrozen ?? this.isFrozen,
      cardLimit: cardLimit ?? this.cardLimit,
    );
  }
}
