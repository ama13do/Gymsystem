import 'package:flutter/material.dart';

class RoutinesScreen extends StatefulWidget {
  @override
  _RoutinesScreenState createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  final List<Map<String, dynamic>> _routines = [
    {
      'title': 'Rutina de Piernas',
      'time': '40 minutos',
      'repetitions': '4 series de 12 repeticiones',
      'machine': 'Máquina de piernas',
      'imageUrl': 'https://i.ibb.co/YbKtY6H/leg-exercise.jpg',
      'description': 'Fortalece piernas y glúteos con esta rutina de alta intensidad.',
      'intensity': 'Alta'
    },
    {
      'title': 'Rutina de Brazo',
      'time': '30 minutos',
      'repetitions': '3 series de 15 repeticiones',
      'machine': 'Máquina de bíceps',
      'imageUrl': 'https://i.ibb.co/k1PfgJz/arm-exercise.jpg',
      'description': 'Ejercicios para tonificar los brazos y mejorar la fuerza.',
      'intensity': 'Media'
    },
    {
      'title': 'Rutina de Abdomen',
      'time': '20 minutos',
      'repetitions': '3 series de 20 repeticiones',
      'machine': 'Banco de abdominales',
      'imageUrl': 'https://i.ibb.co/2cH0Fhq/abs-exercise.jpg',
      'description': 'Fortalece tu abdomen con estos ejercicios de nivel avanzado.',
      'intensity': 'Alta'
    },
  ];

  final _formKey = GlobalKey<FormState>();
  String _newTitle = '';
  String _newTime = '';
  String _newRepetitions = '';
  String _newMachine = '';
  String _newImageUrl = '';
  String _newDescription = '';
  String _newIntensity = '';

  void _addRoutine() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _routines.add({
          'title': _newTitle,
          'time': _newTime,
          'repetitions': _newRepetitions,
          'machine': _newMachine,
          'imageUrl': _newImageUrl,
          'description': _newDescription,
          'intensity': _newIntensity
        });
      });
      Navigator.pop(context);
    }
  }

  void _showAddRoutineForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, top: 20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Agregar Rutina',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    _buildTextField('Nombre de la rutina', (value) => _newTitle = value),
                    _buildTextField('Tiempo estimado', (value) => _newTime = value),
                    _buildTextField('Repeticiones', (value) => _newRepetitions = value),
                    _buildTextField('Máquina', (value) => _newMachine = value),
                    _buildTextField('URL de la imagen', (value) => _newImageUrl = value),
                    _buildTextField('Descripción', (value) => _newDescription = value),
                    _buildTextField('Intensidad (Alta, Media, Baja)',
                        (value) => _newIntensity = value),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _addRoutine,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                      child: Text('Agregar Rutina'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: onChanged,
        validator: (value) =>
            value == null || value.isEmpty ? 'Este campo es obligatorio' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rutinas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _routines.length,
        itemBuilder: (context, index) {
          final routine = _routines[index];
          return _buildRoutineCard(
            routine: routine,
            onCompleted: () {
              setState(() {
                _routines.removeAt(index);
              });
            },
            onNotCompleted: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('¡No te rindas! Tú puedes seguir intentándolo.'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoutineForm,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildRoutineCard({
    required Map<String, dynamic> routine,
    required VoidCallback onCompleted,
    required VoidCallback onNotCompleted,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen y título
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    routine['imageUrl'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    routine['title'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Detalles de la rutina
            Text('Tiempo estimado: ${routine['time']}', style: TextStyle(fontSize: 16)),
            Text('Repeticiones: ${routine['repetitions']}', style: TextStyle(fontSize: 16)),
            Text('Máquina: ${routine['machine']}', style: TextStyle(fontSize: 16)),
            Text('Intensidad: ${routine['intensity']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            // Descripción
            Text(
              routine['description'],
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            // Botón para marcar completada/no finalizada
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onCompleted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Completada'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onNotCompleted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('No finalizada'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
