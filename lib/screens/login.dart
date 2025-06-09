import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/screens/bloc/authentication/bloc.dart';
import 'package:invest_manager/widgets/input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key})
      : usernameField = TextInputField(labelText: 'Username'),
        passwordField = PasswordField(labelText: 'Password');

  final TextInputField usernameField;
  final PasswordField passwordField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200.0,
            ),
            usernameField,
            SizedBox(
              height: 40.0,
            ),
            passwordField,
            SizedBox(
              height: 50.0,
            ),
            SubmitButton(
              onSubmit: () => BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthRequestEvent(
                username: usernameField.currentValue,
                password: passwordField.currentValue,
              )),
              text: 'Login',
            )
          ],
        ),
      ),
    ));
  }
}
