import 'package:flutter/material.dart';
import 'package:news/features/home/components/categories_list_widget.dart';
import 'package:news/features/home/components/top_headLines_list.dart';
import 'package:news/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Categories" ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          CategoriesListWidget(),
          Expanded(
            child: Consumer<HomeController>(
              builder: (context, controller, _) =>
                  CustomScrollView(slivers: [TopHeadlinesList()]),
            ),
          ),
        ],
      ),
    );
  }
}
