import 'package:flutter/material.dart';
import 'pcos_models.dart';
import 'pcos_results_page.dart';

class PCOSQuestionPage extends StatefulWidget {
  final int questionIndex;
  final Function(List<int>) onComplete;

  const PCOSQuestionPage({
    super.key,
    required this.questionIndex,
    required this.onComplete,
  });

  @override
  State<PCOSQuestionPage> createState() => _PCOSQuestionPageState();
}

class _PCOSQuestionPageState extends State<PCOSQuestionPage> {
  late List<int> answers;
  int? selectedOption;
  final Color primaryPink = const Color(0xFFEC407A); // Consistent pink color

  @override
  void initState() {
    super.initState();
    answers = List<int>.filled(pcosQuestions.length, -1);
  }

  void _saveAnswerAndContinue() {
    if (selectedOption == null) return;

    answers[widget.questionIndex] = selectedOption!;

    if (widget.questionIndex < pcosQuestions.length - 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PCOSQuestionPage(
            questionIndex: widget.questionIndex + 1,
            onComplete: widget.onComplete,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PCOSResultsPage(answers: answers),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = pcosQuestions[widget.questionIndex];
    final progressValue = (widget.questionIndex + 1) / pcosQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PCOS Risk Assessment",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryPink,
                Color.lerp(
                    primaryPink, const Color.fromARGB(255, 176, 39, 135), 0.3)!,
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(primaryPink),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${widget.questionIndex + 1}/${pcosQuestions.length}",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Question card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Options
            Expanded(
              child: ListView.separated(
                itemCount: question.options.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: selectedOption == index
                        ? primaryPink.withOpacity(0.1)
                        : Colors.grey[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: selectedOption == index
                            ? primaryPink
                            : Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {
                          selectedOption = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedOption == index
                                      ? primaryPink
                                      : Colors.grey[400]!,
                                  width: 2,
                                ),
                              ),
                              child: selectedOption == index
                                  ? Center(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primaryPink,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                question.options[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.questionIndex > 0)
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: primaryPink),
                      ),
                      child: Text(
                        "Back",
                        style: TextStyle(color: primaryPink),
                      ),
                    ),
                  if (widget.questionIndex == 0) const Spacer(),
                  ElevatedButton(
                    onPressed:
                        selectedOption == null ? null : _saveAnswerAndContinue,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: primaryPink,
                      foregroundColor: Colors.white,
                      elevation: 2,
                    ),
                    child: Text(
                      widget.questionIndex < pcosQuestions.length - 1
                          ? "Continue"
                          : "Get Results",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
