class ContactModel {
  final String id;
  final String name;
  final String avatar;
  final String accountNumber;
  final bool isFavorite;
  final DateTime? lastTransaction;

  ContactModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.accountNumber,
    required this.isFavorite,
    this.lastTransaction,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      accountNumber: json['accountNumber'] as String,
      isFavorite: json['isFavorite'] as bool,
      lastTransaction: json['lastTransaction'] != null
          ? DateTime.parse(json['lastTransaction'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'accountNumber': accountNumber,
      'isFavorite': isFavorite,
      'lastTransaction': lastTransaction?.toIso8601String(),
    };
  }

  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

  ContactModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? accountNumber,
    bool? isFavorite,
    DateTime? lastTransaction,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      accountNumber: accountNumber ?? this.accountNumber,
      isFavorite: isFavorite ?? this.isFavorite,
      lastTransaction: lastTransaction ?? this.lastTransaction,
    );
  }
}
