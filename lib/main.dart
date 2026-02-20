import 'package:flutter/material.dart';

class FoodItem {
  final String name;
  final DateTime expirationDate;
  
FoodItem({required this.name, required this.expirationDate});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // changed to FoodItem type
  final items = [
      FoodItem(name: 'Pizza', expirationDate: DateTime(2024, 6, 22)),
      FoodItem(name: 'Sushi', expirationDate: DateTime(2024, 6, 20)),
      FoodItem(name: 'Burger', expirationDate: DateTime(2024, 6, 21)),
  ];

  void _addItem() {
    final itemController = TextEditingController();
    final expirationDateController = TextEditingController();

    showDialog(
      context: context, 
      builder:(context) => AlertDialog(
        title: const Text('Add New Item'),
        content: Column(
          children: [
            TextField(
              controller: itemController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: expirationDateController,
              decoration: const InputDecoration(labelText: 'Expiration Date (MM/DD/YYYY)'),
            )
          ]
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')
          ),
          TextButton(
            onPressed: () {
              // splits the expiration date into month, day, and year
              final parts = expirationDateController.text.split('/');
              final month = int.parse(parts[0]);
              final day = int.parse(parts[1]);
              final year = int.parse(parts[2]);
              
              // changed to add FoodItem type
              setState(() {
                items.add(FoodItem(
                  name: itemController.text, 
                  expirationDate: DateTime(year, month, day)
                ));
              });

              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: ListView(
        // changed to add FoodItem type and format expiration date as MM/DD/YYYY
        children: items.map((item) {
          final formattedDate = '${item.expirationDate.month}/${item.expirationDate.day}/${item.expirationDate.year}';
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Expiration Date: $formattedDate'),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}