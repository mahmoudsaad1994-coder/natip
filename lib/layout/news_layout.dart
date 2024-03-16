import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/componants/components.dart';
import '../modules/search_screen/search_screem.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeThemeMode();
                },
                icon: const Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: cubit.changeBottomNavBar,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
