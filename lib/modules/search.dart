import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store/models/search/search_model.dart';
import 'package:store/shared/cubit/home/home_cubit.dart';
import 'package:store/shared/cubit/search/search.dart';
import 'package:store/shared/cubit/search/search_states.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Search',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).getSearch(text);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter text to search';
                        }
                      },
                      controller: searchController,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Search',
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is GetSearchLoadingState)
                      LinearProgressIndicator(),
                    if (state is GetSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildSearchItem(
                                SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data[index],
                                context),
                            separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data
                                .length),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(Product model, context) {
    return Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 120,
          width: 120,
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                style: TextStyle(
                    fontSize: 16.0, height: 1.5, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${model.price.round()}',
                style: TextStyle(color: Colors.teal, height: 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
