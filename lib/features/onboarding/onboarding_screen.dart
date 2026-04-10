import 'package:flutter/material.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/features/onboarding/models/onboarding_model.dart';
import 'package:news/features/onboarding/onboarding_controller.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingController(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,

            actions: [
              Consumer<OnboardingController>(
                builder: (BuildContext context, controller, Widget? child) {
                  return controller.isLastIndex
                      ? SizedBox.shrink()
                      : TextButton(
                          onPressed: () {
                            // Navigate to the next screen or perform any action
                            controller.onFinish(context);
                          },
                          child: Text('Skip'),
                        );
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.spacingWidth16,
              vertical: AppSizes.paddingVertical30,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: Provider.of<OnboardingController>(
                      context,
                      listen: false,
                    ).pageController,
                    onPageChanged: (index) {
                      Provider.of<OnboardingController>(
                        context,
                        listen: false,
                      ).onPageChanged(index);
                    },
                    itemBuilder: (context, index) {
                      final OnboardingModel onboardingItem =
                          OnboardingModel.onboardingData[index];
                      return Column(
                        children: [
                          Image.asset(onboardingItem.imagePath),
                          SizedBox(height: AppSizes.spacingHeight20),
                          Text(
                            onboardingItem.title,
                            style: TextStyle(
                              fontSize: AppSizes.fontSize20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff4E4B66),
                            ),
                          ),
                          SizedBox(height: AppSizes.spacingHeight12),
                          Text(
                            onboardingItem.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppSizes.fontSize16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6E7191),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: OnboardingModel.onboardingData.length,
                  ),
                ),
                Consumer<OnboardingController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return SmoothPageIndicator(
                      controller: value.pageController, // PageController
                      count: 3,
                      effect: JumpingDotEffect(), // your preferred effect
                      onDotClicked: (index) {
                        Provider.of<OnboardingController>(
                          context,
                          listen: false,
                        ).animateToPage(index);
                      },
                    );
                  },
                ),
                SizedBox(height: AppSizes.spacingHeight112),
                Consumer<OnboardingController>(
                  builder:
                      (
                        BuildContext context,
                        OnboardingController value,
                        Widget? child,
                      ) {
                        return ElevatedButton(
                          onPressed: () {
                            if (!value.isLastIndex) {
                              Provider.of<OnboardingController>(
                                context,
                                listen: false,
                              ).nextPage();
                            } else {
                              // Navigate to the next screen or perform any action
                              value.onFinish(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              AppSizes.spacingHeight52,
                            ),
                          ),
                          child: Text(
                            Provider.of<OnboardingController>(
                                  context,
                                  listen: false,
                                ).isLastIndex
                                ? 'Get Started'
                                : 'Next',
                          ),
                        );
                      },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
