import 'package:store/models/profile/profile_model.dart';

abstract class HomeStates {}

class InitialHomeState extends HomeStates {}

class ChangeBottomNavBarState extends HomeStates {}

class GetHomeDataLoadingState extends HomeStates {}

class GetHomeDataSuccessState extends HomeStates {}

class GetHomeDataErrorState extends HomeStates {}

class GetCatDataLoadingState extends HomeStates {}

class GetCatDataSuccessState extends HomeStates {}

class GetCatDataErrorState extends HomeStates {}

class ChangeFavoritesLoadingState extends HomeStates {}

class ChangeFavoritesSuccessState extends HomeStates {}

class ChangeFavoritesErrorState extends HomeStates {}

class GetProfileLoadingState extends HomeStates {}

class GetProfileSuccessState extends HomeStates {
  final Profile model;

  GetProfileSuccessState(this.model);
}

class GetProfileErrorState extends HomeStates {}

class GetFavoritesLoadingState extends HomeStates {}

class GetFavoritesSuccessState extends HomeStates {}

class GetFavoritesErrorState extends HomeStates {}

