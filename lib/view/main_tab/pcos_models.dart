class PCOSQuestion {
  final String question;
  final List<String> options;

  PCOSQuestion(this.question, this.options);
}

final List<PCOSQuestion> pcosQuestions = [
  PCOSQuestion("Do you have irregular periods (cycles longer than 35 days)?",
      ["Never", "Occasionally", "Frequently", "Always"]),
  PCOSQuestion(
      "Do you experience excessive hair growth on face, chest or back?",
      ["No", "Mild", "Moderate", "Severe"]),
  PCOSQuestion(
      "Have you noticed significant hair thinning or male-pattern baldness?",
      ["No", "Mild", "Moderate", "Severe"]),
  PCOSQuestion("Do you have acne that persists after adolescence?",
      ["No", "Mild", "Moderate", "Severe"]),
  PCOSQuestion("Have you been diagnosed with obesity or overweight?",
      ["No", "Slightly overweight", "Overweight", "Obese"]),
  PCOSQuestion(
      "Do you have difficulty losing weight despite diet and exercise?",
      ["No", "Sometimes", "Often", "Always"]),
  PCOSQuestion(
      "Do you have patches of dark, velvety skin (neck, armpits, groin)?",
      ["No", "Small patches", "Moderate patches", "Large patches"]),
  PCOSQuestion("Do you experience pelvic pain?",
      ["Never", "Occasionally", "Frequently", "Always"]),
  PCOSQuestion("Have you had difficulty getting pregnant?",
      ["Not applicable", "No", "Some difficulty", "Major difficulty"]),
  PCOSQuestion("Do you have a family history of PCOS?",
      ["No", "Possibly", "Yes, one relative", "Yes, multiple relatives"]),
];
