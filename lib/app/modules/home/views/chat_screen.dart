import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../../../theme/app_theme.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${controller.messageThread.value?.senderId ?? 'User'}'),
              radius: 16,
            ),
            const SizedBox(height: 4),
            Text(
              controller.messageThread.value?.senderId ?? 'User',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(20),
                reverse: true,
                itemCount: controller.chatHistory.length,
                itemBuilder: (context, index) {
                  // Reverse index because list is reversed
                  final message = controller.chatHistory[controller.chatHistory.length - 1 - index];
                  return _buildChatBubble(message);
                },
              ),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    if (message.amount != null) {
      return _buildTransferBubble(message);
    }

    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: Get.width * 0.7),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.secondaryBackground : AppColors.accentLime,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(message.isMe ? 20 : 4),
            bottomRight: Radius.circular(message.isMe ? 4 : 20),
          ),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: message.isMe ? AppColors.textPrimary : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTransferBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        width: Get.width * 0.5,
        decoration: BoxDecoration(
          color: message.isMe ? const Color(0xFFC0E0E0).withOpacity(0.2) : AppColors.accentLime.withOpacity(0.9),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: message.isMe ? AppColors.textSecondary : Colors.black54,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message.amount!,
              style: TextStyle(
                color: message.isMe ? AppColors.textPrimary : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (message.note != null) ...[
              const SizedBox(height: 8),
              Text(
                message.note!,
                style: TextStyle(
                  color: message.isMe ? AppColors.textSecondary : Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.monetization_on, color: AppColors.accentLime, size: 28),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: controller.textController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  hintText: 'Money or message',
                  hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.accentLime,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
