part of 'bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRequestEvent extends AuthEvent {
  const AuthRequestEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class Logout extends AuthEvent {
  const Logout();
}
