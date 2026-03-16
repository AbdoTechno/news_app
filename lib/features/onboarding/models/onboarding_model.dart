class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  static List<OnboardingModel> onboardingData = [
    OnboardingModel(
      title: 'Trending News',
      description:
          'Stay in the loop with the biggest breaking stories in a stunning visual slider. Just swipe to explore what’s trending right now!',
      imagePath: 'assets/images/onboarding1.png',
    ),
    OnboardingModel(
      title: 'Pick What You Love',
      description:
          'No more endless scrolling! Tap into your favorite topics like Tech, Politics, or Sports and get personalized news in seconds',
      imagePath: 'assets/images/onboarding2.png',
    ),
    OnboardingModel(
      title: 'Save It. Read It Later. Stay Smart.',
      description:
          'Found something interesting? Tap the bookmark and come back to it anytime. Never lose a great read again!',
      imagePath: 'assets/images/onboarding3.png',
    ),
  ];
}
