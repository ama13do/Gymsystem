import 'package:flutter/material.dart';

class RoutinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rutinas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 5, // Número de rutinas (puedes hacerlo dinámico)
        itemBuilder: (context, index) {
          return _buildRoutineCard(
            title: 'Rutina ${index + 1}',
            time: '30 minutos',
            repetitions: '3 series de 15 repeticiones',
            machine: 'Máquina de piernas',
            imageUrl: 'https://via.placeholder.com/150', // URL de imagen
            description: 'Ejercicio para fortalecer las piernas y glúteos.',
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para agregar nueva rutina
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildRoutineCard({
    required String title,
    required String time,
    required String repetitions,
    required String machine,
    required String imageUrl,
    required String description,
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
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
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
            Text('Tiempo estimado: $time', style: TextStyle(fontSize: 16)),
            Text('Repeticiones: $repetitions', style: TextStyle(fontSize: 16)),
            Text('Máquina: $machine', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            // Descripción
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            // Botón para marcar completada/no finalizada
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para marcar completada
                  },
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
                  onPressed: () {
                    // Lógica para marcar no finalizada
                  },
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
