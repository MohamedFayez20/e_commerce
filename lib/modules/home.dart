import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/models/categories/categories_model.dart';
import 'package:store/models/home/home_model.dart';
import 'package:store/shared/cubit/home/home_cubit.dart';
import 'package:store/shared/cubit/home/home_states.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: BuildCondition(
            condition: HomeCubit.get(context).homeModel != null &&
                HomeCubit.get(context).categoriesModel != null,
            builder: (context) => bannersBuilder(
                HomeCubit.get(context).homeModel!,
                HomeCubit.get(context).categoriesModel!,
                context),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget bannersBuilder(
      HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, right: 10.0, bottom: 10.0, left: 10.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 120.0,
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    buildCatItem(categoriesModel.data!.data[index]),
                separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                itemCount: categoriesModel.data!.data.length),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, right: 10.0, bottom: 10.0, left: 10.0),
            child: Text(
              'New Products',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.68,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.products.length,
                (index) => productBuilder(model.data!.products[index], context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCatItem(CategoriesData model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 120.0,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          height: 25,
          width: 120,
          color: Colors.black45,
          child: Text(
            '${model.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  Widget productBuilder(Products model, context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 200,
            ),
            Spacer(),
            if (model.discount != 0)
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
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  style: TextStyle(color: Colors.teal, height: 2),
                ),
                SizedBox(
                  width: 10.0,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                        color: Colors.red,
                        height: 2,
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    HomeCubit.get(context).changeFavorites(model.id);
                  },
                  icon: HomeCubit.get(context).favorites[model.id]!
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
    );
  }
}
