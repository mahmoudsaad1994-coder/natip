import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../layout/web_view.dart';

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          WebViewScreen(
            url: article['url'],
            title: article['title'],
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(article['urlToImage'] ??
                    'https://media.istockphoto.com/id/929047972/vector/world-news-flat-vector-icon-news-symbol-logo-illustration-business-concept-simple-flat.jpg?s=612x612&w=0&k=20&c=5jpcJ7xejjFa2qKCzeOXKJGeUl7KZi9qoojZj1Kq_po='),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

ConditionalBuilder articleBuilder(List<dynamic> cubitList,
    {bool isSearch = false}) {
  return ConditionalBuilder(
    condition: cubitList.isNotEmpty,
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          buildArticleItem(cubitList[index], context),
      separatorBuilder: (context, index) => const Divider(indent: 20),
      itemCount: cubitList.length,
    ),
    fallback: (cotext) => isSearch
        ? Container()
        : const Center(child: CircularProgressIndicator()),
  );
}

navigateTo(context, widget, {bool backOrNo = true}) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return backOrNo;
    });

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType inputType,
  required String labelText,
  required IconData prefixIcon,
  required var validat,
  bool isPassword = false,
  bool readOnly = false,
  var inSubmit,
  var onChanged,
  var suffixOnPressed,
  Function()? onTap,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixOnPressed == null
            ? null
            : IconButton(
                icon: isPassword
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
                onPressed: suffixOnPressed),
      ),
      keyboardType: inputType,
      obscureText: isPassword,
      onFieldSubmitted: inSubmit,
      onChanged: onChanged,
      validator: validat,
      onTap: onTap,
      readOnly: readOnly,
    );
