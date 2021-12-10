import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/models/register/register_model.dart';
import 'package:store/shared/component/end_points.dart';
import 'package:store/shared/cubit/register/register_states.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  late RegisterModel model;
  void userRegister(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    }).then((value) {
      model = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(model));
      print('success');
    });
  }

  bool isPassword = false;
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
