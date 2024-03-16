import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/componants/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var searchControlor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchList = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormFeild(
                  controller: searchControlor,
                  inputType: TextInputType.text,
                  labelText: 'search',
                  prefixIcon: Icons.search,
                  validat: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search must be not empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(searchList, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
