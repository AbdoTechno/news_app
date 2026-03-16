import 'package:flutter/material.dart';
import 'package:news/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return HomeController()..init();
      },

      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Home Screen')),
            body: (controller.errorMessage?.isNotEmpty ?? false)
                ? Center(child: Text(controller.errorMessage!))
                : controller.everythingLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.everythingArticles.length,
                          itemBuilder: (context, index) {
                            final article =
                                controller.everythingArticles[index];
                            return ListTile(
                              title: Text(article.title ?? 'No Title'),
                              subtitle: Text(
                                article.description ?? 'No Description',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
