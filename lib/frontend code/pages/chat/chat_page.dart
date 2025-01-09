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

  @override
  void initState() {
    super.initState();

    // Add the bot's initial message
    ChatMessage initialMessage = ChatMessage(
      text: "Hello! 👋 I am a Quick Chat Bot. How can I assist you today?\n\n"
          "Here are some common topics:\n"
          "1. Appointment Issues\n"
          "2. Health Education Resources\n"
          "3. Technical Support\n\n"
          "Please type the number of the topic you'd like help with.",
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
    } else if (currentContext == "health_education") {
      handleHealthEducation(chatMessage);
    } else if (currentContext == "technical_support") {
      handleTechnicalSupport(chatMessage);
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
            "2. Rescheduling or canceling\n",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "2") {
      currentContext = "health_education";
      ChatMessage reply = ChatMessage(
        text: "Great! What specific health topic are you interested in?\n"
            "1. Nutrition\n"
            "2. Exercise\n"
            "3. Mental Health",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "3") {
      currentContext = "technical_support";
      ChatMessage reply = ChatMessage(
        text: "Let's resolve your technical issues. Please specify:\n"
            "1. App not loading\n"
            "2. Account issues\n"
            "3. Other technical problems",
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
            "You selected Booking an appointment. Here's how you can proceed:\n\n"
            "- Navigate to the appointment page using the bottom navigation bar.\n"
            "- Tap the 'Book New Appointment' button.\n"
            "- Choose your date, time slot and the reason of appointment.\n"
            "- Tap 'Confirm Appointment' and a confirmation message will pop out, indicating your booking is successful!",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "2") {
      ChatMessage reply = ChatMessage(
        text:
            "You selected Rescheduling or canceling. Here's what you can do:\n\n"
            "- Navigate to the appointment page using the bottom navigation bar.\n"
            "- If you have an upcoming appointment, you can choose to cancel or reschedule the appointment.\n"
            "- Choose your date and time slot for the new schedule.\n"
            "- Tap 'Confirm Appointment' and a confirmation message will pop out, indicating your reschedule is successful!",
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

  void handleHealthEducation(ChatMessage chatMessage) {
    if (chatMessage.text == "1") {
      ChatMessage reply = ChatMessage(
        text: "You selected Nutrition. Here are some resources:\n\n"
            "- Proteins: Essential for building and repairing tissues, making enzymes and hormones.\n"
            "- Carbohydrates: The body's primary energy source.\n"
            "- Fats: Provide energy and support cell growth.\n",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "2") {
      ChatMessage reply = ChatMessage(
        text: "You selected Exercise. Here are some benefits of exercising:\n\n"
            "- Strengthens the heart and lungs.\n"
            "- Increases flexibility and muscle strength.\n"
            "- Enhances balance and coordination.",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "3") {
      ChatMessage reply = ChatMessage(
        text: "You selected Mental Health. Here's some advice:\n\n"
            "- Build strong social connections.\n"
            "- Practice mindfulness and meditation.\n"
            "- Do physical activity regularly.",
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

  void handleTechnicalSupport(ChatMessage chatMessage) {
    if (chatMessage.text == "1") {
      ChatMessage reply = ChatMessage(
        text: "You selected App not loading. Try these steps:\n\n"
            "- Restarting the app",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "2") {
      ChatMessage reply = ChatMessage(
        text: "You selected Account issues. Here's how to resolve them:\n\n"
            "- Restarting the app",
        user: bot,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages = [reply, ...messages];
      });
    } else if (chatMessage.text == "3") {
      ChatMessage reply = ChatMessage(
        text:
            "You selected Other technical problems. Please describe the issue:",
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

  void defaultResponse() {
    ChatMessage reply = ChatMessage(
      text:
          "Sorry, I didn't understand that. Please type the number of the topic you'd like help with.",
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
