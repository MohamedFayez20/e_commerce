import 'package:store/models/login/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel model;

  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginStates {}

class VisibilityState extends LoginStates {}
