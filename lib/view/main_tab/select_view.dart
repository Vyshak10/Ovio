import 'package:flutter/material.dart';
import 'calender.dart';
import 'pcos_results_page.dart';
import 'pcos_question_page.dart';
import 'menstrual_cycle_guide_page.dart';

class SelectView extends StatelessWidget {
  const SelectView({super.key});

  void _startPCOSAssessment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PCOSQuestionPage(
              questionIndex: 0,
              onComplete: (List<int> answers) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PCOSResultsPage(answers: answers),
                  ),
                );
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Health Features",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Assessment",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildSplitContainer(
                context,
                title: "Predict",
                subtitle: "PCOS Risk Assessment",
                buttonText: "Start",
                color: Colors.blue.shade100,
                imagePath: "assets/img/doctorA.jpg",
                onPressed: () => _startPCOSAssessment(context),
                buttonColor: Colors.white,
                textColor: Colors.black87,
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Wellness Tips",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildSplitContainer(
                context,
                title: "Tips",
                subtitle: "Make your cycle easier",
                buttonText: "Learn More",
                color: const Color.fromARGB(255, 239, 77, 99),
                imagePath: "assets/img/listen.jpg",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenstrualCycleGuidePage(),
                    ),
                  );
                },
                buttonColor: Colors.white,
                textColor: Colors.black87,
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Cycle Tracking",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildSplitContainer(
                context,
                title: "Mark and Track",
                buttonText: "Start",
                subtitle: "Track your cycle",
                color: const Color.fromARGB(255, 172, 106, 216),
                imagePath: "assets/img/cale.jpg",
                onPressed: () {
                  // Navigate to the CalendarScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalendarScreen(),
                    ),
                  );
                },
                buttonColor: Colors.white,
                textColor: const Color.fromARGB(255, 239, 77, 99),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSplitContainer(
    BuildContext context, {
    required String title,
    String? subtitle,
    required String buttonText,
    required Color color,
    required String imagePath,
    required VoidCallback onPressed,
    required Color buttonColor,
    required Color textColor,
  }) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 5),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 32,
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                        ),
                        onPressed: onPressed,
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
