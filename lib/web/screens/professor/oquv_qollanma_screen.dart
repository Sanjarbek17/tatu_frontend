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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Nomi')),
            DataColumn(label: Text('Muallif')),
            DataColumn(label: Text('Yili')),
          ],
          rows:
              data.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item['title']!)),
                    DataCell(Text(item['author']!)),
                    DataCell(Text(item['year']!)),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
