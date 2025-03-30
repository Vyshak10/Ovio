import 'package:flutter/material.dart';
import 'package:healthcare/common/color_extension.dart';
import './../../common_widget/round_button.dart';
import 'package:healthcare/view/on_boarding/on_boarding_view.dart';

class StartedView extends StatefulWidget {
  const StartedView({super.key});

  @override
  State<StartedView> createState() => _StartedViewState();
}

class _StartedViewState extends State<StartedView> {
  bool showBackgroundImage = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        children: [
          Container(
            width: media.width,
            decoration: BoxDecoration(
              image: showBackgroundImage
                  ? const DecorationImage(
                      image: AssetImage("assets/img/ovia.png"),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: showBackgroundImage
                      ? Container() // Ensures layout consistency
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "OVIA",
                              style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RoundButton(
                      title: "Get Started",
                      type: showBackgroundImage
                          ? RoundButtonType.textGradient
                          : RoundButtonType.bgGradient,
                      onPressed: () {
                        if (showBackgroundImage) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OnBoardingView()));
                        } else {
                          setState(() {
                            showBackgroundImage = true;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
