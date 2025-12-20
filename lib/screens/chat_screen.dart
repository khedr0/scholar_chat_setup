import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  static String id = "ChatScreen";
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 45,
              image: AssetImage("assets/images/scholar.png"),
            ),
            Text(
              "Chat",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ChatBubble();
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 6, bottom: 16.0, left: 8, right: 8),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: primaryColor),
                ),
                hintText: "Type a message",
              ),
            ),
          )
        ],
      ),
    );
  }
}
