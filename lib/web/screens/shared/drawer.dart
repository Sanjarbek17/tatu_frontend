import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'title': 'Dashboard', 'icon': Icons.dashboard, 'screen': '/dashboard'},
    {'title': 'Sales', 'icon': Icons.bar_chart, 'screen': '/sales'},
    {'title': 'Analytics', 'icon': Icons.analytics, 'screen': '/analytics'},
    {'title': 'Layouts', 'icon': Icons.view_quilt, 'screen': '/layouts'},
    {
      'title': 'Online Courses',
      'icon': Icons.school,
      'screen': '/online-courses',
    },
    {'title': 'Finance', 'icon': Icons.attach_money, 'screen': '/finance'},
    {'title': 'Membership', 'icon': Icons.group, 'screen': '/membership'},
    {'title': 'User', 'icon': Icons.person, 'screen': '/user'},
    {'title': 'Elements', 'icon': Icons.widgets, 'screen': '/elements'},
    {'title': 'Basic', 'icon': Icons.layers, 'screen': '/basic'},
    {'title': 'Advance', 'icon': Icons.upgrade, 'screen': '/advance'},
    {'title': 'Icons', 'icon': Icons.insert_emoticon, 'screen': '/icons'},
    {
      'title': 'Forms Elements',
      'icon': Icons.format_align_left,
      'screen': '/forms-elements',
    },
    {
      'title': 'Forms Plugins',
      'icon': Icons.extension,
      'screen': '/forms-plugins',
    },
    {'title': 'Landing page', 'icon': Icons.web, 'screen': '/landing-page'},
    {
      'title': 'Authentication',
      'icon': Icons.lock,
      'screen': '/authentication',
    },
    {'title': 'Settings', 'icon': Icons.settings, 'screen': '/settings'},
    {'title': 'Email', 'icon': Icons.email, 'screen': '/email'},
    {'title': 'Chat', 'icon': Icons.chat, 'screen': '/chat'},
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
                    context.go(
                      items[index]['screen'],
                    ); // Navigate using go_router
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
