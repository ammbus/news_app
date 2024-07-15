import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/domain/usecases/authenticate_user.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}
class LogoutRequested extends AuthEvent {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateUser authenticateUser;

  AuthBloc({required this.authenticateUser}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final isAuthenticated = await authenticateUser(event.username, event.password);
        if (isAuthenticated) {
          emit(AuthSuccess());
        } else {
          emit(AuthFailure(error: 'Invalid username or password'));
        }
      } catch (e) {
        emit(AuthFailure(error: 'An error occurred. Please try again.'));
      }
    });

    on<LogoutRequested>((event, emit) async {
     
      emit(AuthInitial());
    });
  }
}
