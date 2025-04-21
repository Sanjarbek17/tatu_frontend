import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'title': 'Dashboard', 'icon': Icons.dashboard},
    {'title': 'Sales', 'icon': Icons.bar_chart},
    {'title': 'Analytics', 'icon': Icons.analytics},
    {'title': 'Layouts', 'icon': Icons.view_quilt},
    {'title': 'Online Courses', 'icon': Icons.school},
    {'title': 'Finance', 'icon': Icons.attach_money},
    {'title': 'Membership', 'icon': Icons.group},
    {'title': 'User', 'icon': Icons.person},
    {'title': 'Elements', 'icon': Icons.widgets},
    {'title': 'Basic', 'icon': Icons.layers},
    {'title': 'Advance', 'icon': Icons.upgrade},
    {'title': 'Icons', 'icon': Icons.insert_emoticon},
    {'title': 'Forms Elements', 'icon': Icons.format_align_left},
    {'title': 'Forms Plugins', 'icon': Icons.extension},
    {'title': 'Landing page', 'icon': Icons.web},
    {'title': 'Authentication', 'icon': Icons.lock},
    {'title': 'Settings', 'icon': Icons.settings},
    {'title': 'Email', 'icon': Icons.email},
    {'title': 'Chat', 'icon': Icons.chat},
  ];

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   height: 150,
          //   color: Colors.blue,
          //   child: Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           'John Smith',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Text(
          //           'Administrator',
          //           style: TextStyle(color: Colors.white70, fontSize: 16),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(items[index]['icon'], color: Colors.blue),
                  title: Text(
                    items[index]['title'],
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    // Handle navigation logic here
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
