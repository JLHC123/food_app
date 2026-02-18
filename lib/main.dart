import 'package:flutter/material.dart';

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
  final items = {
      'Pizza': DateTime(2026, 02, 16),
      'Burger': DateTime(2026, 02, 17),
      'Sushi': DateTime(2026, 02, 18),
  };

  void _addItem() {
    showDialog(
      context: context, 
      builder:(context) => AlertDialog(
        title: const Text('Add New Item'),
        content: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Expiration Date'),
            )
          ]
        ),
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
        children: items.entries.map((entry) {
          final date = entry.value;
          final formattedDate = '${date.month}/${date.day}/${date.year}';
          return ListTile(
            title: Text(entry.key),
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