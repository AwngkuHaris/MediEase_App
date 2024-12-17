import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Gemini gemini = Gemini.instance;
  ChatUser user = ChatUser(id: '1');
  ChatUser bot = ChatUser(id: '2', firstName: "Bot");

  List<ChatMessage> messages = [];

  // Handle sending of new messages
  void onSend(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCEECE3),
      body: DashChat(
        currentUser: user,
        onSend: onSend,
        messages: messages,
        messageOptions: MessageOptions(
          currentUserContainerColor: Colors.white,
          currentUserTextColor: Colors.black,
        ),
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
            prefixIcon: const Icon(Icons.attachment),
            suffixIcon: const Icon(Icons.camera_alt),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Message....',
            hintStyle: TextStyle(color: Colors.grey[600]),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}