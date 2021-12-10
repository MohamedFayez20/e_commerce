import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store/shared/cubit/register/register_cubit.dart';
import 'package:store/shared/cubit/register/register_states.dart';
import 'package:store/shared/network/local/cache_helper.dart';

import '../layout/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.model.status == true) {
              print(state.model.status);
              Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              CacheHelper.saveData(key: 'token', value: state.model.status)
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              });
            } else {
              print('error');
              Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: HexColor('#23323f'),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: HexColor('#23323f'),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                    },
                    controller: nameController,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#313D4D'),
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.person_pin,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                    },
                    controller: phoneController,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#313D4D'),
                      labelText: 'Phone',
                      labelStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                    },
                    controller: emailController,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#313D4D'),
                      labelText: 'Email Address',
                      labelStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                    },
                    controller: passwordController,
                    cursorColor: Colors.white,
                    obscureText: RegisterCubit.get(context).isPassword,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#313D4D'),
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          RegisterCubit.get(context).changeVisibility();
                        },
                        icon: RegisterCubit.get(context).suffix,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BuildCondition(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
