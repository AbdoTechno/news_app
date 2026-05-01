import 'package:flutter/material.dart';
import 'package:news/core/datasource/remote_data/api_service.dart';
import 'package:news/core/repos/news_repository.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/features/details/details_screen.dart';
import 'package:news/features/search/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SearchScreenController(NewsRepository(ApiService()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search', style: TextStyle(color: Color(0xffA0A0A0))),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.paddingHorizontal16),
          child: Consumer<SearchScreenController>(
            builder:
                (
                  BuildContext context,
                  SearchScreenController controller,
                  Widget? child,
                ) {
                  return Column(
                    children: [
                      TextField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.getEverything();
                        },
                        decoration: InputDecoration(
                          hint: Text("Search"),
                          suffixIcon: Icon(
                            Icons.search_rounded,
                            color: Color(0xffA0A0A0),
                            size: AppSizes.borderRadius30,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.spacingHeight16),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) =>
                              Divider(height: AppSizes.spacingHeight16),
                          itemCount: controller.everythingArticles.length,
                          itemBuilder: (context, index) {
                            final news = controller.everythingArticles[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsScreen(model: news),
                                    ),
                                  );
                                },
                                leading: Icon(
                                  Icons.search_rounded,
                                  size: AppSizes.borderRadius16,
                                ),

                                title: Text(
                                  maxLines: 1,
                                  news.title ?? "",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
          ),
        ),
      ),
    );
  }
}
