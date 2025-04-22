import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final bool
  isProfessor; // Added parameter to determine if the user is a professor

  final List<Map<String, dynamic>> items;

  CustomDrawer({
    required this.onItemSelected,
    required this.selectedScreen,
    required this.isProfessor, // Initialize isProfessor
    super.key,
  }) : items = [
         {
           'title': 'Dashboard',
           'icon': Icons.dashboard,
           'screen': '/dashboard',
         },
         {
           'title': 'Professor Articles',
           'icon': Icons.article,
           'screen': '/professor-articles',
         },
         if (isProfessor)
           {
             'title': 'Add Article',
             'icon': Icons.add,
             'screen': '/add-article',
           },
         if (isProfessor)
           {
             'title': 'Analytics',
             'icon': Icons.analytics,
             'screen': '/analytics',
           },
         if (isProfessor)
           {
             'title': 'Online Courses',
             'icon': Icons.school,
             'screen': '/online-courses',
           },
         if (isProfessor)
           {
             'title': 'Settings',
             'icon': Icons.settings,
             'screen': '/settings',
           },
       ];

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
              itemCount: items.length,
              itemBuilder: (context, index) {
                final isSelected = items[index]['screen'] == selectedScreen;
                return ListTile(
                  leading: Icon(
                    items[index]['icon'],
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                  title: Text(
                    items[index]['title'],
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.blue : Colors.grey,
                    ),
                  ),
                  onTap: () {
                    onItemSelected(items[index]['screen']);
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
