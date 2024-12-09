import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gymsystem/views/auth/login.dart';
import 'firebase_options.dart'; // Archivo generado automáticamente

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym System',
      home: LoginScreen(), // Pantalla de inicio
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crear Colecciones en Firestore',
      home: CreateCollectionsScreen(),
    );
  }
}

class CreateCollectionsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _createCollections() async {
    try {
      // Crear Usuarios
      final usuariosRef = _firestore.collection('Usuarios');
      final usuarioDoc = await usuariosRef.add({
        'nombre': 'Juan',
        'apellido': 'Pérez',
        'estatus': 'activo',
        'telefono': '555-1234',
        'fecha_inicio_suscripcion': DateTime.now(),
        'fecha_final_suscripcion': DateTime.now().add(Duration(days: 365)),
        'cantidad_rutinas_hechas': 5,
        'cantidad_rutinas_en_proceso': 3,
        'visitas_gym_ultimo_mes': 10,
        'visitas_gym_ultimo_anio': 120,
        'url_perfil': 'https://example.com/profile.jpg',
        'nivel': 'Intermedio',
      });

      // Crear Productos
      final productosRef = _firestore.collection('Productos');
      await productosRef.add({
        'nombre': 'Proteína Whey',
        'precio': 500.0,
        'stock': 20,
        'descripcion': 'Proteína para desarrollar masa muscular.',
        'url': 'https://example.com/product.jpg',
        'requiere_mayoria_edad': false,
      });
      await productosRef.add({
        'nombre': 'Pre-Entreno',
        'precio': 300.0,
        'stock': 15,
        'descripcion': 'Mejora el rendimiento antes de entrenar.',
        'url': 'https://example.com/preworkout.jpg',
        'requiere_mayoria_edad': false,
      });

      // Crear Rutinas
      final rutinasRef = usuariosRef.doc(usuarioDoc.id).collection('Rutinas');
      await rutinasRef.add({
        'nombre': 'Rutina de fuerza',
        'descripcion': 'Ejercicios para aumentar fuerza muscular.',
        'nivel': 'Avanzado',
        'repeticiones': 10,
        'tiempo': 60, // Tiempo en minutos
      });
      await rutinasRef.add({
        'nombre': 'Rutina de resistencia',
        'descripcion': 'Ejercicios para mejorar la resistencia.',
        'nivel': 'Intermedio',
        'repeticiones': 15,
        'tiempo': 45,
      });

      // Crear Chats
      final chatsRef = usuariosRef.doc(usuarioDoc.id).collection('Chats');
      await chatsRef.add({
        'role': 'ia',
        'mensaje': 'Hola, ¿cómo puedo ayudarte con tu entrenamiento?',
        'timestamp': FieldValue.serverTimestamp(),
      });
      await chatsRef.add({
        'role': 'coach',
        'mensaje': 'Recuerda completar tus rutinas esta semana.',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Crear Tips
      final tipsRef = usuariosRef.doc(usuarioDoc.id).collection('Tips');
      await tipsRef.add({
        'descripcion': 'Realiza siempre un calentamiento antes de entrenar.',
        'timestamp': FieldValue.serverTimestamp(),
      });
      await tipsRef.add({
        'descripcion': 'Mantente hidratado durante todo el entrenamiento.',
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Colecciones creadas exitosamente con datos de prueba.');
    } catch (e) {
      print('Error al crear las colecciones: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Colecciones en Firestore'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _createCollections,
          child: Text('Crear Colecciones'),
        ),
      ),
    );
  }
}

*/