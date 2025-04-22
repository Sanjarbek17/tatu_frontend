import 'package:flutter/material.dart';
import 'package:tatu_frontend/core/constants.dart';

class CustomDrawer extends StatelessWidget {
  final bool
  isProfessor; // Added parameter to determine if the user is a professor

  CustomDrawer({
    required this.onItemSelected,
    required this.selectedScreen,
    required this.isProfessor, // Initialize isProfessor
    super.key,
  });

  final Function(String) onItemSelected;
  final String selectedScreen; // Added to track selected screen

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                final isSelected =
                    drawerItems[index]['screen'] == selectedScreen;
                return ListTile(
                  leading: Icon(
                    drawerItems[index]['icon'],
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                  title: Text(
                    drawerItems[index]['title'],
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.blue : Colors.grey,
                    ),
                  ),
                  onTap: () {
                    onItemSelected(drawerItems[index]['screen']);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
