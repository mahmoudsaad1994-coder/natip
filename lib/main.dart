import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:natiq/shared/bloc_observer.dart';

import 'layout/news_layout.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

void main(List<String> args) async {
  //بيتاكد ان كل حاجه خلصت الاول وبعدين يدخل ينفذ الرن اب
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  NewsAppDioHelper.init();
  await NewsAppCacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // news app bloc
        BlocProvider(
            // في حاله لو عايز كل الداتا تتحمل مره واحده
            create: (BuildContext context) => NewsCubit()
            // ..getBusiness()
            // ..getScience()
            // ..getSports(),
            // create: (BuildContext context) => NewsCubit()..getBusiness(),
            ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: NewsAppCacheHelper.getData(key: 'isDark') == null
                  ? ThemeMode.system
                  : NewsAppCacheHelper.getData(key: 'isDark')!
                      ? ThemeMode.dark
                      : ThemeMode.light,
              home: const NewsLayout() // homeWidget,
              );
        },
      ),
    );
  }
}
