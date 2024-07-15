import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/blocs/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text('Dark Mode'),
          value: Theme.of(context).brightness == Brightness.dark,
          onChanged: (bool value) {
            context.read<ThemeBloc>().add(ThemeEvent.toggle);
          },
        ),
      ),
    );
  }
}
