import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends StatelessWidget {
  final String userId; // ID del usuario para identificar los datos en Firestore

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color(0xff0043ba),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Usuarios').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No se encontraron datos del usuario.'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TopPortion(urlPerfil: userData['url_perfil'] ?? ''),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        userData['nombre'] ?? 'Sin nombre',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Suscripción: ${userData['nivel'] ?? 'Sin nivel'}",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Estado: ${userData['estatus'] ?? 'Desconocido'}",
                        style: TextStyle(
                          color: userData['estatus'] == 'activo' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Inicio: ${_formatDate(userData['fecha_inicio_suscripcion'])}  |  Fin: ${_formatDate(userData['fecha_final_suscripcion'])}",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tipo de Cliente: Cliente Regular",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      _ProfileInfoRow(
                        rutinasHechas: userData['cantidad_rutinas_hechas'] ?? 0,
                        rutinasProceso: userData['cantidad_rutinas_en_proceso'] ?? 0,
                        visitasMes: userData['visitas_gym_ultimo_mes'] ?? 0,
                      ),
                      const SizedBox(height: 16),
                      _CredentialCard(userData: userData),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return 'Sin fecha';
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final int rutinasHechas;
  final int rutinasProceso;
  final int visitasMes;

  const _ProfileInfoRow({
    Key? key,
    required this.rutinasHechas,
    required this.rutinasProceso,
    required this.visitasMes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoItem('Rutinas Completadas', rutinasHechas),
          _buildInfoItem('Rutinas en Proceso', rutinasProceso),
          _buildInfoItem('Visitas último mes', visitasMes),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class _TopPortion extends StatelessWidget {
  final String urlPerfil;

  const _TopPortion({Key? key, required this.urlPerfil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xff0043ba), Color(0xff006df1)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(urlPerfil),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _CredentialCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const _CredentialCard({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Credencial Virtual',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            QrImageView(
              data:
                  '${userData['nombre'] ?? ''}\nTipo de suscripción: ${userData['nivel'] ?? ''}\n${userData['estatus'] ?? ''}\nFecha de inicio: ${_formatDate(userData['fecha_inicio_suscripcion'])}\nFecha final: ${_formatDate(userData['fecha_final_suscripcion'])}',
              version: QrVersions.auto,
              size: 150.0,
            ),
            const SizedBox(height: 16),
            Text(
              '${userData['nombre'] ?? ''}\nCliente Regular\nSuscripción ${userData['nivel'] ?? ''}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return 'Sin fecha';
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }
}
