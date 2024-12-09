import 'package:flutter/material.dart';
import 'package:gymsystem/views/chat/chatCoach.dart';
import 'package:gymsystem/views/chat/chatIa.dart';

class ChatSelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Chat'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: isDesktop ? 400 : double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón: Chat con IA
                _buildChatOption(
                  context,
                  icon: Icons.smart_toy,
                  label: 'Chat con IA',
                  onPressed: () {
                    // Navega a la pantalla de chat con IA
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatWithIAScreen()), // Para chat con IA
                    );
                  },
                ),
                SizedBox(height: 20),
                // Botón: Chat con Coach
                _buildChatOption(
                  context,
                  icon: Icons.person,
                  label: 'Chat con Coach',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatWithCoachScreen()), // Para chat con Coach
                    );
                    // Navega a la pantalla de chat con Coach
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        elevation: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.blueAccent,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
