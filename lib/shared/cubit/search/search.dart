import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/models/search/search_model.dart';
import 'package:store/shared/component/end_points.dart';
import 'package:store/shared/cubit/search/search_states.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  Search? searchModel;
  void getSearch(String text) {
    emit(GetSearchLoadingState());
    DioHelper.postData(
            url: SEARCH,
            data: {
              'text': text,
            },
            token: CacheHelper.getData(key: 'token').toString())
        .then((value) {
      searchModel = Search.fromJson(value.data);
      emit(GetSearchSuccessState());
    }).catchError((error) {
      emit(GetSearchErrorState());
      print(error.toString());
    });
  }
}
