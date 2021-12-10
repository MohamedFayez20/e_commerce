import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/models/categories/categories_model.dart';
import 'package:store/models/getfavorites/favorites.dart';
import 'package:store/models/getfavorites/getfavorites.dart';
import 'package:store/models/home/home_model.dart';
import 'package:store/models/profile/profile_model.dart';
import 'package:store/models/search/search_model.dart';
import 'package:store/modules/categories.dart';
import 'package:store/modules/favorite_screen.dart';
import 'package:store/modules/home.dart';
import 'package:store/modules/settings.dart';
import 'package:store/shared/component/end_points.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    Home(),
    Categories(),
    FavoritesScreen(),
    Settings(),
  ];
  List<String> titles = ['Home', 'Categories', 'Favorites', 'Profile'];
  int currentIndex = 0;
  void changeBottomNavState(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int, bool?> favorites = {};
  void getHomeData() {
    emit(GetHomeDataLoadingState());
    DioHelper.getData(
            url: HOME, token: CacheHelper.getData(key: 'token').toString())
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites.toString());
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      emit(GetHomeDataErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCatData() {
    emit(GetCatDataLoadingState());
    DioHelper.getData(
            url: CATEGORIES,
            token: CacheHelper.getData(key: 'token').toString())
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetCatDataSuccessState());
    }).catchError((error) {
      emit(GetCatDataErrorState());
    });
  }

  FavoritesModel? favoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesSuccessState());
    DioHelper.postData(
            url: FAVORITES,
            data: {'product_id': productId},
            token: CacheHelper.getData(key: 'token').toString())
        .then((value) => {
              emit(ChangeFavoritesSuccessState()),
              favoritesModel = FavoritesModel.fromJson(value.data),
              print(value.data),
              if (favoritesModel!.status == false)
                {favorites[productId] = !favorites[productId]!}
              else
                {
                  getFavorites(),
                },
            })
        .catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ChangeFavoritesErrorState());
    });
  }

  Profile? userModel;
  void getUserData() {
    DioHelper.getData(
      url: PROFILE,
      token: CacheHelper.getData(key: 'token').toString(),
    ).then((value) {
      userModel = Profile.fromJson(value.data);
      print(userModel!.data!.name);
      emit(GetProfileSuccessState(userModel!));
    }).catchError((error) {
      emit(GetProfileErrorState());
    });
  }

  Favorites? favoritesM;
  void getFavorites() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: CacheHelper.getData(key: 'token').toString(),
    ).then((value) {
      favoritesM = Favorites.fromJson(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((error) {
      emit(GetFavoritesErrorState());
      print(error.toString());
    });
  }

}
