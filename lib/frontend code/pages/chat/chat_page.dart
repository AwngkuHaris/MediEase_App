import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatUser user = ChatUser(id: '1');
  ChatUser bot = ChatUser(id: '2', firstName: "Bot");

  List<ChatMessage> messages = [];
  String currentContext = "main_menu"; // Tracks the current context

  // Initial Quick Replies
  List<QuickReply> initialQuickReplies = [
    QuickReply(
      title: "1",
      value: "appointment_issues",
    ),
    QuickReply(
      title: "2",
      value: "health_education",
    ),
    QuickReply(
      title: "3",
      value: "technical_support",
    ),
    QuickReply(
      title: "4",
      value: "other_questions",
    ),
  ];

  // Follow-Up Quick Replies for Appointment Issues
  List<QuickReply> appointmentQuickReplies = [
    QuickReply(
      title: "1",
      value: "booking_appointment",
    ),
    QuickReply(
      title: "2",
      value: "rescheduling_canceling",
    ),
    QuickReply(
      title: "3",
      value: "viewing_details",
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Add the bot's initial message
    ChatMessage initialMessage = ChatMessage(
      text: "Hello! 👋 I am a Quick Chat Bot. How can I assist you today?\n\n"
          "Here are some common topics:\n"
          "1. Appointment Issues\n"
          "2. Health Education Resources\n"
          "3. Technical Support\n"
          "4. Other Questions\n\n"
          "Please type the number of topic you'd like help with.",
      user: bot,
      createdAt: DateTime.now(),
    );

    setState(() {
      messages = [initialMessage];
    });
  }

  void onSend(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    // Handle user input based on the current context
    if (currentContext == "main_menu") {
      handleMainMenu(chatMessage);
    } else if (currentContext == "appointment_issues") {
      handleAppointmentIssues(chatMessage);
    } else {
      defaultResponse();
    }
  }

  void handleMainMenu(ChatMessage chatMessage) {
    if (chatMessage.text == "1") {
      currentContext = "appointment_issues"; // Update context
      ChatMessage reply = ChatMessage(
        text: "Got it! Are you facing any of these issues?\n\n"
            "1. Booking an appointment\n"
            "2. Rescheduling or canceling\n"
            "3. Viewing appointment details",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "2") {
      ChatMessage reply = ChatMessage(
        text:
            "You choose health education resources.",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    }else if (chatMessage.text == "3") {
      ChatMessage reply = ChatMessage(
        text:
            "You choose Technical support",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    }else if (chatMessage.text == "4") {
      ChatMessage reply = ChatMessage(
        text:
            "You choose other questions.",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else {
      defaultResponse();
    }
  }

  void handleAppointmentIssues(ChatMessage chatMessage) {
    if (chatMessage.text == "1") {
      ChatMessage reply = ChatMessage(
        text:
            "You selected Booking an appointment",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "2") {
      ChatMessage reply = ChatMessage(
        text:
            "You selected Rescheduling or canceling",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "3") {
      ChatMessage reply = ChatMessage(
        text:
            "You selected Viewing appointment details",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    }else {
      defaultResponse();
    }
  }

  void defaultResponse() {
    ChatMessage reply = ChatMessage(
      text:
          "Sorry, I didn't understand that. Please type the number of topic you'd like help with.",
      user: bot,
      createdAt: DateTime.now(),
    );

    setState(() {
      messages = [reply, ...messages];
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
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.white,
          currentUserTextColor: Colors.black,
        ),
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
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
