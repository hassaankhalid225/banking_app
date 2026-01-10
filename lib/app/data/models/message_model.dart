class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String message;
  final double? amount;
  final DateTime timestamp;
  final bool isRead;
  final String messageType; // text, transfer

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.amount,
    required this.timestamp,
    required this.isRead,
    required this.messageType,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      amount: json['amount'] != null
          ? (json['amount'] as num).toDouble()
          : null,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool,
      messageType: json['messageType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'messageType': messageType,
    };
  }

  bool get isTextMessage => messageType == 'text';
  bool get isTransferMessage => messageType == 'transfer';

  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? receiverId,
    String? message,
    double? amount,
    DateTime? timestamp,
    bool? isRead,
    String? messageType,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      messageType: messageType ?? this.messageType,
    );
  }
}
