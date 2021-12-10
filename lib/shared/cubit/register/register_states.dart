import 'package:store/models/register/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates {}

class VisibilityState extends RegisterStates {}
