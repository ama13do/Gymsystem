import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createUser({
  required String userId, // ID único del usuario
  required String nombre,
  required String apellido,
  required String telefono,
  required String urlPerfil,
  required String nivel,
  required DateTime fechaInicio,
  required DateTime fechaFinal,
  required bool estatus,
}) async {
  await FirebaseFirestore.instance.collection('Usuarios').doc(userId).set({
    'nombre': nombre,
    'apellido': apellido,
    'telefono': telefono,
    'estatus': estatus ? 'activo' : 'inactivo',
    'fecha_inicio_suscripcion': fechaInicio,
    'fecha_final_suscripcion': fechaFinal,
    'cantidad_rutinas_hechas': 0,
    'cantidad_rutinas_en_proceso': 0,
    'visitas_gym_ultimo_mes': 0,
    'visitas_gym_ultimo_anio': 0,
    'url_perfil': urlPerfil,
    'nivel': nivel,
  });
}

Future<void> createProduct({
  required String nombre,
  required double precio,
  required int stock,
  required String descripcion,
  required String url,
  required bool requiereMayoriaEdad,
}) async {
  await FirebaseFirestore.instance.collection('Productos').add({
    'nombre': nombre,
    'precio': precio,
    'stock': stock,
    'descripcion': descripcion,
    'url': url,
    'requiere_mayoria_edad': requiereMayoriaEdad,
  });
}

Future<void> createRoutine({
  required String userId,
  required String nombre,
  required String descripcion,
  required String nivel,
  required int repeticiones,
  required int tiempo,
}) async {
  await FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(userId)
      .collection('Rutinas')
      .add({
    'nombre': nombre,
    'descripcion': descripcion,
    'nivel': nivel,
    'repeticiones': repeticiones,
    'tiempo': tiempo,
  });
}


Future<void> createChat({
  required String userId,
  required String role, // 'ia' o 'coach'
  required String mensaje,
}) async {
  await FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(userId)
      .collection('Chats')
      .add({
    'role': role,
    'mensaje': mensaje,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

Future<void> createTip({
  required String userId,
  required String descripcion,
}) async {
  await FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(userId)
      .collection('Tips')
      .add({
    'descripcion': descripcion,
    'timestamp': FieldValue.serverTimestamp(),
  });
}


class CreateUserScreen extends StatelessWidget {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _urlPerfilController = TextEditingController();
  final TextEditingController _nivelController = TextEditingController();
  bool estatus = true;

  Future<void> _saveUser() async {
    final fechaInicio = DateTime.now();
    final fechaFinal = fechaInicio.add(Duration(days: 365));

    await FirebaseFirestore.instance.collection('Usuarios').add({
      'nombre': _nombreController.text,
      'apellido': _apellidoController.text,
      'telefono': _telefonoController.text,
      'estatus': estatus ? 'activo' : 'inactivo',
      'fecha_inicio_suscripcion': fechaInicio,
      'fecha_final_suscripcion': fechaFinal,
      'cantidad_rutinas_hechas': 0,
      'cantidad_rutinas_en_proceso': 0,
      'visitas_gym_ultimo_mes': 0,
      'visitas_gym_ultimo_anio': 0,
      'url_perfil': _urlPerfilController.text,
      'nivel': _nivelController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _telefonoController,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: _urlPerfilController,
              decoration: InputDecoration(labelText: 'URL Perfil'),
            ),
            TextField(
              controller: _nivelController,
              decoration: InputDecoration(labelText: 'Nivel'),
            ),
            SwitchListTile(
              title: Text('Estatus'),
              value: estatus,
              onChanged: (value) {
                estatus = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUser,
              child: Text('Guardar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
