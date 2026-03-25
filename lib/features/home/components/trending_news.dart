import 'package:flutter/material.dart';
import 'package:news/core/enums/request_status_enums.dart';
import 'package:news/features/home/components/trendinag_card.dart';
import 'package:news/features/home/components/view_all.dart';
import 'package:news/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class TrendinagNews extends StatelessWidget {
  const TrendinagNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset('assets/images/back_ground.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            top: 70,
            child: Column(
              children: [
                Text(
                  "NEWST",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ViewAll(title: "Trending News", color: Colors.white),
                SizedBox(
                  height: 170,
                  child: Consumer<HomeController>(
                    builder:
                        (
                          BuildContext context,
                          HomeController controller,
                          Widget? child,
                        ) {
                          switch (controller.everythingRequestStatus) {
                            case RequestStatusEnums.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case RequestStatusEnums.error:
                              return Center(
                                child: Text(
                                  controller.errorMessage ?? 'An error occurred',
                                ),
                              );
                            case RequestStatusEnums.success:
                              return TrendinagCard();
                          }
                        },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
