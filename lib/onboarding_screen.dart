import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky_app/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const routeName = 'OnboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingData> onboardingData = dataOnboarding();
  int index = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                itemBuilder: (context, index) {
                  return CustomAnimatedWidget(
                    delay: index,
                    index: index,
                    child: Image.asset(onboardingData[index].imagePath),
                  );
                },
                itemCount: onboardingData.length,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SmoothPageIndicator(
              controller: controller,
              count: onboardingData.length,
              effect: ExpandingDotsEffect(
                spacing: 5,
                radius: 10,
                dotHeight: 5,
                dotWidth: 10,
                dotColor: Color(0xffAFAFAF),
                activeDotColor: Color(0xff5F33E1),
              ),
            ),
            CustomAnimatedWidget(
              delay: index * 100,
              index: index,
              child: Container(
                margin: EdgeInsets.all(40),
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      onboardingData[index].title,
                      style: TextStyle(
                        color: Color(0xff24252C),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      onboardingData[index].description,
                      style: TextStyle(
                        color: Color(0xff6E6A7C),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  height: 48,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    if (index < onboardingData.length - 1) {
                      controller.nextPage(
                          duration: Duration(microseconds: 500),
                          curve: Curves.easeIn);
                    } else {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    }
                  },
                  color: Color(0xff5F33E1),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    index < onboardingData.length - 1 ? 'NEXT' : 'GET STARTED',
                    style: TextStyle(color: Color(0xffFFFFFF)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAnimatedWidget extends StatelessWidget {
  const CustomAnimatedWidget({
    super.key,
    required this.index,
    required this.delay,
    required this.child,
  });
  final Widget child;
  final int index;
  final int delay;
  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }
}

List<OnboardingData> dataOnboarding() {
  return [
    OnboardingData(
      imagePath: 'assets/images/onboarding_screen_1.png',
      title: 'Manage your tasks',
      description:
          'You can easily manage all of your daily tasks in DoMe for free',
    ),
    OnboardingData(
      imagePath: 'assets/images/onboarding_screen_2.png',
      title: 'Create daily routine',
      description:
          'In Tasky  you can create your personalized routine to stay productive',
    ),
    OnboardingData(
      imagePath: 'assets/images/onboarding_screen_3.png',
      title: 'Orgonaize your tasks',
      description:
          'You can organize your daily tasks by adding your tasks into separate categories',
    ),
  ];
}

class OnboardingData {
  OnboardingData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
  String imagePath;
  String title;
  String description;
}
