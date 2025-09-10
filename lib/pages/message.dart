import 'package:flutter/material.dart';

// Modèle de données pour un message
class Message {
  final String text;
  final bool isSentByMe; // true si c'est un message envoyé par l'utilisateur
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [
    Message(
      text: "Bonjour ! Comment ça va ?",
      isSentByMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    Message(
      text: "Salut ! Je vais bien, et toi ?",
      isSentByMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    Message(
      text: "Je vais bien aussi, merci ! 😃",
      isSentByMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    Message(
      text: "Super ! Je voulais te parler de quelque chose...",
      isSentByMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    // Créer un nouveau message
    final newMessage = Message(
      text: text,
      isSentByMe: true, // Toujours vrai pour les messages envoyés depuis l'input
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(newMessage);
      _textController.clear();
    });

    // Défiler vers le bas après l'envoi d'un message
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          "Conversation",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Liste des messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),
          // Barre de saisie de message
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Row(
        children: [
          // Champ de texte
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: "Écrivez un message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // Bouton d'envoi
          FloatingActionButton(
            mini: true,
            onPressed: () => _handleSubmitted(_textController.text),
            backgroundColor: Colors.blue.shade800,
            elevation: 0,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// Widget pour une seule bulle de message
class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Aligner la bulle à droite si le message est envoyé par moi, sinon à gauche
    final alignment =
        message.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final color = message.isSentByMe ? Colors.blue.shade800 : Colors.grey.shade300;
    final textColor = message.isSentByMe ? Colors.white : Colors.black87;

    return Row(
      mainAxisAlignment: alignment,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: const Center(child: Text("Vos messages ici")),
    );
  }
}