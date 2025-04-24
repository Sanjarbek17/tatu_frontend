import 'package:flutter/material.dart';

class OquvQollanmaScreen extends StatelessWidget {
  const OquvQollanmaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {'title': 'Matematika', 'author': 'John Doe', 'year': '2020'},
      {'title': 'Fizika', 'author': 'Jane Smith', 'year': '2019'},
      {'title': 'Kimyo', 'author': 'Albert Brown', 'year': '2021'},
      {'title': 'Biologiya', 'author': 'Emily White', 'year': '2018'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('O‘quv qo‘llanma')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
            item['title']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
            'Muallif: ${item['author']!}\nYili: ${item['year']!}',
              ),
            ),
          ],
            ),
          ),
        ),
          );
        },
      ),
    );
  }
}
