import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:invest_manager/components/db.dart';

part 'events.dart';
part 'states.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthenticationState> {
  AuthenticationBloc() : super(const NotAuthenticated()) {
    on<Logout>((event, emit) async {
      emit(const NotAuthenticated());
    });

    on<AuthRequestEvent>((event, emit) async {
      emit(Authenticating(
        username: event.username,
        password: event.password,
      ));

      await Future.delayed(Duration(seconds: 5));

      if (event.username == "admin" && event.password == "admin") {
        emit(Authenticated(userDatabase: getDatabase()));
      } else {
        emit(AuthenticationDenied(
          username: event.username,
          password: event.password,
        ));
      }
    });
  }

  Future<Database> getUserDatabase() {
    return (state as Authenticated).userDatabase;
  }
}
