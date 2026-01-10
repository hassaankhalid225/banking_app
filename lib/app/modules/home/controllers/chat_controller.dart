import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/message_model.dart';

class ChatController extends GetxController {
  final Rx<MessageModel?> messageThread = Rx<MessageModel?>(null);
  final TextEditingController textController = TextEditingController();
  final RxList<ChatMessage> chatHistory = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    messageThread.value = Get.arguments as MessageModel?;
    _loadChatHistory();
  }

  void _loadChatHistory() {
    // Mocking chat history based on design
    chatHistory.assignAll([
      ChatMessage(content: 'You have been transferred', amount: '\$215', isMe: false),
      ChatMessage(content: 'Thanks!', isMe: true),
      ChatMessage(content: 'Transfer done', amount: '\$15', isMe: false),
      ChatMessage(content: 'Transfer done', amount: '\$26', isMe: true),
      ChatMessage(content: 'Transfer done', amount: '\$310', isMe: true, note: 'I return the debt'),
    ]);
  }

  void sendMessage() {
    if (textController.text.isNotEmpty) {
      chatHistory.add(ChatMessage(content: textController.text, isMe: true));
      textController.clear();
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

class ChatMessage {
  final String content;
  final String? amount;
  final bool isMe;
  final String? note;

  ChatMessage({required this.content, this.amount, required this.isMe, this.note});
}
