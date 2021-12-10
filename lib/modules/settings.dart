import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store/modules/login.dart';
import 'package:store/shared/cubit/home/home_cubit.dart';
import 'package:store/shared/cubit/home/home_states.dart';
import 'package:store/shared/network/local/cache_helper.dart';

class Settings extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          nameController.text = HomeCubit.get(context).userModel!.data!.name!;
          phoneController.text = HomeCubit.get(context).userModel!.data!.phone!;
          emailController.text = HomeCubit.get(context).userModel!.data!.email!;
          return Scaffold(
            backgroundColor: HexColor('#23323f'),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                    },
                    controller: nameController,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#313D4D'),
                      hintText: 'Name',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
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
                    readOnly: true,
                    controller: emailController,
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                    },
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
                    readOnly: true,
                    controller: phoneController,
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                    },
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#313D4D'),
                      hintText: 'Phone',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextButton(
                            onPressed: () {
                              CacheHelper.removeData(key: 'token')
                                  .then((value) {
                                if (value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                }
                              });
                            },
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
