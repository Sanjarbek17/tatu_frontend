import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/providers/auth_provider.dart';

class ProfessorSettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const ProfessorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(title: Text('Settings'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              subtitle: Text('View and edit your profile information'),
              onTap: () {
                // Navigate to profile settings
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              subtitle: Text('Update your account password'),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await authProvider.logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
