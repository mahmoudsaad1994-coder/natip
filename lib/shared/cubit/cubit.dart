import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/buisness_screen/buisness_screen.dart';
import '../../modules/science_screen/science_screen.dart';
import '../../modules/sports_screen/sports_screen.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';
import 'states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavlState());
  }

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<String> titles = [
    'Business News',
    'Sports News',
    'Science News',
  ];

  List business = [];

  getBusiness() {
    emit(NewsGetBusinessLoadingState());

    NewsAppDioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '1601a1f06f0b4b5e9cbdfa0e9e516f9b',
    }).then((value) {
      // print(value.data['articles']);
      business = value.data['articles'];
      print(business.length);
      emit(NewsGetBusinessSuccesState());
    }).catchError((onError) {
      print('error from business $onError');
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  List sports = [];

  getSports() {
    if (sports.isEmpty) {
      emit(NewsGetSportsLoadingState());

      NewsAppDioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '1601a1f06f0b4b5e9cbdfa0e9e516f9b',
      }).then((value) {
        // print(value.data['articles']);
        sports = value.data['articles'];
        print(sports.length);
        emit(NewsGetSportsSuccesState());
      }).catchError((onError) {
        print('error from sports $onError');
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportsSuccesState());
    }
  }

  List science = [];

  getScience() {
    if (science.isEmpty) {
      emit(NewsGetScienceLoadingState());

      NewsAppDioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '1601a1f06f0b4b5e9cbdfa0e9e516f9b',
      }).then((value) {
        // print(value.data['articles']);
        science = value.data['articles'];
        emit(NewsGetScienceSuccesState());
      }).catchError((onError) {
        print('error from Science $onError');
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccesState());
    }
  }

  List search = [];

  getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    NewsAppDioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '1601a1f06f0b4b5e9cbdfa0e9e516f9b',
    }).then((value) {
      // print(value.data['articles']);
      search = value.data['articles'];
      emit(NewsGetSearchSuccesState());
    }).catchError((onError) {
      print('error from Science $onError');
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }

  bool isDark = NewsAppCacheHelper.getData(key: 'isDark') ?? false;

  changeThemeMode() {
    isDark = !isDark;
    print('isDark $isDark');
    NewsAppCacheHelper.setData(key: 'isDark', value: isDark).then((value) {
      emit(NewsModeChangeState());
    });
  }
}
