import 'package:flutter/material.dart';
import 'package:gymsystem/views/marketplace/cart_screen.dart';
import 'package:gymsystem/views/marketplace/markedplacepay.dart';

class MarketplaceScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Proteína Whey',
      'price': 30.0,
      'stock': 10,
      'description': 'Proteína de alta calidad para construir músculo.',
      'imageUrl': 'https://i.ibb.co/YbKtY6H/leg-exercise.jpg'
    },
    {
      'name': 'Cinturón de Levantamiento',
      'price': 15.0,
      'stock': 5,
      'description': 'Soporte lumbar para levantamientos pesados.',
      'imageUrl': 'https://i.ibb.co/k1PfgJz/arm-exercise.jpg'
    },
    {
      'name': 'Shaker Botella',
      'price': 10.0,
      'stock': 20,
      'description': 'Botella mezcladora para tus batidos.',
      'imageUrl': 'https://i.ibb.co/2cH0Fhq/abs-exercise.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
        backgroundColor: Colors.blueAccent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > 600 ? 2 : 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(context, products[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    int quantity = 1;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product['imageUrl'],
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            // Detalles del producto
            Text(
              product['name'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 5),
            Text('Precio: \$${product['price']}',
                style: TextStyle(fontSize: 16)),
            Text('Stock: ${product['stock']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text(
              product['description'],
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            Spacer(),
            // Control de cantidad y botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botones de cantidad
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (quantity > 1) {
                          quantity--;
                        }
                      },
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        if (quantity < product['stock']) {
                          quantity++;
                        }
                      },
                    ),
                  ],
                ),
                // Botones de agregar al carrito y pagar
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para agregar al carrito
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()),
                        );
                      },
                      child: Text('Agregar al Carrito'),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para pagar ahora
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Pagar Ahora'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
