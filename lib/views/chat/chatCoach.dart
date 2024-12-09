import 'package:flutter/material.dart';

class ChatWithCoachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat con Coach'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Área de mensajes
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                _buildMessage("Hola, ¿cómo puedo ayudarte hoy?", isCoach: true),
                _buildMessage("¿Qué ejercicios me recomiendas para mejorar fuerza?", isCoach: false),
              ],
            ),
          ),
          // Campo de texto para enviar mensajes
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessage(String text, {required bool isCoach}) {
    return Align(
      alignment: isCoach ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isCoach ? Colors.green[100] : Colors.green,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isCoach ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // Lógica para enviar mensaje
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(15),
              backgroundColor: Colors.green,
            ),
            child: Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
