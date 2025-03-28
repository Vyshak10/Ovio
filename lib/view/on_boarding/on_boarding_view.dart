import 'package:flutter/material.dart';
import 'package:healthcare/common_widget/on_boarding_page.dart';
import '../../common/color_extension.dart';
import './../login/signup_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;

      setState(() {});
    });
  }

  List pageArr = [
    {
      "title": "Welcome to Your Cycle Companion",
      "subtitle":
          "Your cycle, your journey! We're here to help you track and understand your menstrual health effortlessly.",
      "image": "assets/img/cup.png"
    },
    {
      "title": "Set & Track",
      "subtitle":
          "Every cycle is unique, and so are you! We’ll help you stay informed and empowered.",
      "image": "assets/img/surf.png"
    },
    {
      "title": "Plan Your Life with Ease",
      "subtitle":
          "Self-care starts with understanding your body. Track your cycle, monitor symptoms, and embrace a healthier you!",
      "image": "assets/img/womenwithsan.png"
    },
    {
      "title": "Predict & Prepare",
      "subtitle":
          "Planning your routine around your cycle? We’ll make it easy for you.",
      "image": "assets/img/calender.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: pageArr.length,
              itemBuilder: (context, index) {
                var pObj = pageArr[index] as Map? ?? {};
                return OnBoardingPage(pObj: pObj);
              }),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    color: TColor.primaryColor1,
                    value: (selectPage + 1) / 4,
                    strokeWidth: 2,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: TColor.primaryColor1,
                      borderRadius: BorderRadius.circular(35)),
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: TColor.white,
                    ),
                    onPressed: () {
                      if (selectPage < 3) {
                        selectPage = selectPage + 1;

                        controller.animateToPage(selectPage,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.bounceInOut);

                        // controller.jumpToPage(selectPage);

                        setState(() {});
                      } else {
                        // Open Welcome Screen
                        Text("Open Welcome Screen");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpView()));
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
