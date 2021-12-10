import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/models/getfavorites/favorites.dart';
import 'package:store/shared/cubit/home/home_cubit.dart';
import 'package:store/shared/cubit/home/home_states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: state is! GetFavoritesLoadingState,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavoritesItem(
                      HomeCubit.get(context).favoritesM!.data!.data[index],
                      context,
                    ),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                    ),
                itemCount:
                    HomeCubit.get(context).favoritesM!.data!.data.length),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildFavoritesItem(FavData model, context) {
    return Row(
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage('${model.product!.image}'),
              height: 120,
              width: 120,
            ),
            if (model.product!.discount != 0)
              Container(
                width: 56,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                color: Colors.red,
              ),
          ],
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                '${model.product!.name}',
                maxLines: 2,
                style: TextStyle(
                    fontSize: 16.0, height: 1.5, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${model.product!.price!.round()}',
                    style: TextStyle(color: Colors.teal, height: 2),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  if (model.product!.discount != 0)
                    Text(
                      '${model.product!.oldPrice!.round()}',
                      style: TextStyle(
                          color: Colors.red,
                          height: 2,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      HomeCubit.get(context)
                          .changeFavorites(model.product!.id!);
                    },
                    icon: HomeCubit.get(context).favorites[model.product!.id]!
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
