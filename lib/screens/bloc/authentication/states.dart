part of 'bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Authenticating extends AuthenticationState {
  const Authenticating({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [
        username,
        password,
      ];
}

class NotAuthenticated extends AuthenticationState {
  const NotAuthenticated();
}

class AuthenticationDenied extends AuthenticationState {
  const AuthenticationDenied({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [
        username,
        password,
      ];
}

class Authenticated extends AuthenticationState {
  const Authenticated();
}
