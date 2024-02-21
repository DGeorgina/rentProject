import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/position.dart';
import '../model/product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    // setProductToDatabase(Product(1, "T-Shirt", "New", Position("Partizanski Odredi", 4)));
    getProductsFromDatabase();
  }

  void getProductsFromDatabase() async {
    List<Product> databaseProd = [];
    final ref = FirebaseDatabase.instance.ref();

    try {
      final snapshot = await ref.child('products').get();
      if (snapshot.exists) {
       for (final child in snapshot.children) {
        Map<dynamic, dynamic> values = child.value as Map<dynamic, dynamic>;
        Product prod = Product(values["id"], values["name"], values["description"], Position(values["position"]["name"], values["position"]["number"],),
        );
        setState(() {
          _products.add(prod);
        });
      }
      } else {
        print('No data available.');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

  }

  void setProductToDatabase(Product product) {
    DatabaseReference postListRef = FirebaseDatabase.instance.ref("products");
    DatabaseReference newPostRef = postListRef.push();
    newPostRef.set({
      "id": product.id,
      "name": product.name,
      "description": product.description,
      "position": {
        "name": product.position.name,
        "number": product.position.number
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text("Welcome! This is the main screen!"),
          backgroundColor: Theme.of(context).colorScheme.outlineVariant),
      body: GridView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                _products[index].name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent),
              ),
              subtitle: Text(
                _products[index].description,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () {
                  setState(() {
                    _products.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
      ),
    );
  }
}
