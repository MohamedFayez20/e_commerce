import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/models/login/login_model.dart';
import 'package:store/shared/component/constants.dart';
import 'package:store/shared/component/end_points.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModel model;
  void userLogin({required String email, required String password} ) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      model = LoginModel.fromJson(value.data);
      print(model.data!.token);
      emit(LoginSuccessState(model));
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

  bool isPassword = true;
  Icon suffix = Icon(
    Icons.visibility,
    color: Colors.grey,
  );
  void changeVisibility() {
    isPassword = !isPassword;
    if (isPassword == false) {
      suffix = Icon(
        Icons.visibility_off_outlined,
        color: Colors.grey,
      );
    } else {
      suffix = Icon(
        Icons.visibility,
        color: Colors.grey,
      );
    }
    emit(VisibilityState());
  }
}
