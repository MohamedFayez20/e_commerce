import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store/layout/home_screen.dart';
import 'package:store/modules/register.dart';
import 'package:store/shared/component/constants.dart';
import 'package:store/shared/cubit/login/login_cubit.dart';
import 'package:store/shared/cubit/login/login_states.dart';
import 'package:store/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            print(state.model.status);
            print(state.model.message);
            if (state.model.status) {
              print(state.model.status);
              Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              CacheHelper.saveData(key: 'token', value: state.model.data!.token)
                  .then((value) {
                token = state.model.data!.token!;
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
                        return 'Email must not be empty';
                      }
                    },
                    controller: emailController,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#313D4D'),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
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
                    controller: passwordController,
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                    },
                    obscureText: LoginCubit.get(context).isPassword,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#313D4D'),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          LoginCubit.get(context).changeVisibility();
                        },
                        icon: LoginCubit.get(context).suffix,
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
                          condition: state is! LoginLoadingState,
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.teal),
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
