import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymsystem/views/chat/chatSelector.dart';
import 'package:gymsystem/views/marketplace/marketplacescreen.dart';
import 'package:gymsystem/views/profile/profile.dart';
import 'package:gymsystem/views/routines/routines_screen.dart';
import 'package:gymsystem/views/auth/login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _tips = [
    'Calienta antes de entrenar para evitar lesiones.',
    'Mantente hidratado durante el ejercicio.',
    'Concéntrate en la forma adecuada para mejores resultados.',
    'La consistencia es clave para progresar.',
    'Descansa lo suficiente para una recuperación óptima.',
    'Sigue una dieta balanceada para maximizar tu rendimiento.',
    'Escucha a tu cuerpo para evitar lesiones.',
    'Incluye variedad en tus rutinas para evitar la monotonía.',
  ];
  int _currentTipIndex = 0;
  late Timer _tipTimer;

  @override
  void initState() {
    super.initState();
    _startTipRotation();
  }

  void _startTipRotation() {
    _tipTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        _currentTipIndex = (_currentTipIndex + 1) % _tips.length;
      });
    });
  }

  @override
  void dispose() {
    _tipTimer.cancel();
    super.dispose();
  }

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
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
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
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                            'Tip Actual',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _tips[_currentTipIndex],
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TipListScreen(tips: _tips),
                                ),
                              );
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
            MaterialPageRoute(
              builder: (context) => ProfilePage(userId: 'ZlCxSGglhiEgvGfmdywp'),
            ),
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

class TipListScreen extends StatelessWidget {
  final List<String> tips;

  TipListScreen({required this.tips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tips'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.lightbulb, color: Colors.blueAccent),
            title: Text(
              tips[index],
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
