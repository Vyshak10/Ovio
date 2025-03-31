import 'package:flutter/material.dart';
import 'pcos_models.dart';
import 'select_view.dart';

class PCOSResultsPage extends StatelessWidget {
  final List<int> answers;
  final Color primaryColor = const Color(0xFF6A1B9A);
  final Color secondaryColor = const Color(0xFFAB47BC);
  final Color accentColor = const Color(0xFFEC407A);

  const PCOSResultsPage({super.key, required this.answers});

  int calculateScore() {
    int score = 0;
    bool hasCriticalSymptoms = false;

    for (int i = 0; i < answers.length; i++) {
      if (answers[i] < 0) continue;

      if ((i == 0 && answers[i] == 2) ||
          (i == 1 && answers[i] == 2) ||
          (i == 2 && answers[i] == 2)) {
        hasCriticalSymptoms = true;
      }

      switch (i) {
        case 0:
        case 1:
        case 2:
          score += (answers[i] + 1) * 2;
          break;
        case 5:
          score += (answers[i] + 1) * 3;
          break;
        default:
          score += answers[i] + 1;
      }
    }

    if (hasCriticalSymptoms && score < 24) score = 24;
    return score;
  }

  String _getRiskLevel(int score) {
    if (score < 12) return "Low Risk";
    if (score < 24) return "Moderate Risk";
    if (score < 36) return "High Risk";
    return "Very High Risk";
  }

  @override
  Widget build(BuildContext context) {
    final score = calculateScore();
    final riskLevel = _getRiskLevel(score);
    final riskColor = _getRiskColor(score);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assessment Results",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Results Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      "YOUR PCOS RISK SCORE",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      score.toString(),
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        color: riskColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: riskColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        riskLevel,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Complete Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SelectView()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "BACK TO HEALTH FEATURES",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRiskColor(int score) {
    if (score < 12) return Colors.green;
    if (score < 24) return Colors.orange;
    if (score < 36) return Colors.red;
    return const Color(0xFF8B0000);
  }
}
