import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/blocs/auth_bloc.dart';
import 'package:news_app/presentation/pages/sign_in_page.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/emilys.png'), // Replace with actual image URL
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'stupid emilys',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'stupid.emilys@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  AccountOption(icon: Icons.person, label: 'My Profile'),
                  AccountOption(icon: Icons.settings, label: 'Settings'),
                  AccountOption(icon: Icons.notifications, label: 'Notifications'),
                  AccountOption(icon: Icons.language, label: 'Language'),
                  AccountOption(icon: Icons.help_outline, label: 'FAQ'),
                  AccountOption(icon: Icons.info_outline, label: 'About App'),
                  AccountOption(icon: Icons.logout, label: 'Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const AccountOption({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        if (label == 'Logout') {
          context.read<AuthBloc>().add(LogoutRequested());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        } else {
          // Handle other options
        }
      },
    );
  }
}
