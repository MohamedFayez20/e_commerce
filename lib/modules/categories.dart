import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/models/categories/categories_model.dart';
import 'package:store/shared/cubit/home/home_cubit.dart';
import 'package:store/shared/cubit/home/home_states.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
            condition: HomeCubit.get(context).categoriesModel != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) => buildCatItem(
                          HomeCubit.get(context)
                              .categoriesModel!
                              .data!
                              .data[index]),
                      separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.shade300,
                            ),
                          ),
                      itemCount: HomeCubit.get(context)
                          .categoriesModel!
                          .data!
                          .data
                          .length),
                ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildCatItem(CategoriesData model) {
    return Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 120,
          width: 120,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 15.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
