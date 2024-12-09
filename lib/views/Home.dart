import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymsystem/views/chat/chatSelector.dart';
import 'package:gymsystem/views/marketplace/marketplacescreen.dart';
import 'package:gymsystem/views/profile/profile.dart';
import 'package:gymsystem/views/routines/routines_screen.dart';
import 'package:gymsystem/views/auth/login.dart'; // Importa la pantalla de inicio de sesión

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Cierra sesión
              await FirebaseAuth.instance.signOut();

              // Navega a la pantalla de inicio de sesión
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false, // Elimina todas las rutas anteriores
              );
            },
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.network(
              'https://static.vecteezy.com/system/resources/previews/017/504/043/non_2x/bodybuilding-emblem-and-gym-logo-design-template-vector.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Fondo translúcido
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Contenido principal
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  // Botones principales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHomeButton(context, Icons.chat, 'Chats'),
                      _buildHomeButton(context, Icons.fitness_center, 'Rutinas'),
                      _buildHomeButton(context, Icons.shopping_cart, 'Marketplace'),
                      _buildHomeButton(context, Icons.person, 'Perfil'),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Tarjeta de tips de gimnasio
                  Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gym Tips',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '1. Calienta antes de entrenar para evitar lesiones.\n'
                            '2. Mantente hidratado durante el ejercicio.\n'
                            '3. Concéntrate en la forma adecuada para mejores resultados.\n'
                            '4. ¡La consistencia es clave para progresar!',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              // Acción para más tips
                            },
                            child: Text(
                              'Ver más tips',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context, IconData icon, String label) {
    return ElevatedButton(
      onPressed: () {
        // Acción según el botón
        if (label == 'Chats') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatSelectorScreen()),
          );
        } else if (label == 'Rutinas') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoutinesScreen()),
          );
        } else if (label == 'Marketplace') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MarketplaceScreen()),
          );
        } else if (label == 'Perfil') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(userId: 'ZlCxSGglhiEgvGfmdywp',)),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white.withOpacity(0.8),
        shadowColor: Colors.black54,
        elevation: 5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: Colors.blueAccent),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
