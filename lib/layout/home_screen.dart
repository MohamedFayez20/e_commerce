import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store/modules/search.dart';
import 'package:store/shared/cubit/home/home_cubit.dart';
import 'package:store/shared/cubit/home/home_states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getHomeData()
        ..getCatData()
        ..getUserData()
        ..getFavorites(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: Text(HomeCubit.get(context)
                    .titles[HomeCubit.get(context).currentIndex]),
                backgroundColor: HexColor('#23323f'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                ]),
            body: HomeCubit.get(context)
                .screens[HomeCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: HomeCubit.get(context).currentIndex,
              onTap: (index) {
                HomeCubit.get(context).changeBottomNavState(index);
              },
              backgroundColor: HexColor('#23323f'),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.teal,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.perm_contact_calendar_outlined),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
