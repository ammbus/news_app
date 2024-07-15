import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'data/data_providers/auth_api.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/authenticate_user.dart';
import 'presentation/blocs/auth_bloc.dart';
import 'presentation/pages/sign_in_page.dart';
import 'presentation/blocs/theme_bloc.dart';

void main() {
  
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authenticateUser: AuthenticateUser(repository: AuthRepositoryImpl(authApi: AuthApi()))),
        ),
        BlocProvider(
          create: (_) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Insight 360',
            theme: theme,
            home: SignInPage(),
          );
        },
      ),
    );
  }
}
