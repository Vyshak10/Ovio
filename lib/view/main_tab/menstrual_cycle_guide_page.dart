import 'package:flutter/material.dart';

class MenstrualCycleGuidePage extends StatelessWidget {
  const MenstrualCycleGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cycle Nutrition Guide',
          style: TextStyle(
            color: Color(0xFF5D5D5D),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFFAF9F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5D5D5D)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image (Replace with your local image path)
            Container(
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/img/nutrion.png'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Article Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'Nutrition and Mood Management Through Your Cycle',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      color: Color(0xFF5D5D5D),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Author and Date
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color.fromARGB(255, 195, 140, 246),
                        child: Text(
                          'SJ',
                          style: TextStyle(
                            color: Color(0xFF5D5D5D),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Dr. Sarah Johnson',
                        style: TextStyle(
                          color: Color(0xFF5D5D5D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Color(0xFF5D5D5D),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'May 15, 2023',
                        style: TextStyle(
                          color: Color(0xFF8E8E8E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Introduction
                  const Text(
                    'The menstrual cycle, with its four distinct phases, significantly affects our body, mind, and emotions. Understanding how to optimize nutrition and manage mood swings during each phase can help women feel better throughout the month.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: Color(0xFF5D5D5D),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Section: Introduction to Menstrual Cycle
                  _buildSectionHeader('Understanding the Menstrual Cycle'),
                  const SizedBox(height: 16),
                  const Text(
                    'The menstrual cycle lasts about 28 days, although it can vary from person to person. It consists of four main phases:',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: Color(0xFF5D5D5D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPhaseList(),
                  const SizedBox(height: 16),
                  const Text(
                    'Each phase involves different hormonal changes, which can impact mood, energy levels, and nutritional needs. By understanding these phases, we can adjust our diet and lifestyle to optimize well-being.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: Color(0xFF5D5D5D),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Menstrual Phase Section
                  _buildPhaseSection(
                    title: '1. Menstrual Phase (Days 1-5)',
                    color: const Color.fromARGB(255, 255, 168, 197),
                    nutritionTitle: 'Nutritional Needs:',
                    nutritionContent:
                        'During the menstrual phase, your body is shedding the uterine lining, which can lead to lower energy levels and potential iron loss due to menstrual bleeding. Nutrition during this phase should focus on replenishing lost nutrients.',
                    foodsTitle: 'Foods to Include:',
                    foods: const [
                      'Iron-rich foods: Leafy greens (spinach, kale), lentils, beans, tofu, quinoa, red meat (for non-vegetarians), and fortified cereals.',
                      'Vitamin C: Helps with iron absorption. Include citrus fruits (oranges, grapefruits), bell peppers, and broccoli.',
                      'Magnesium: To help with cramps and fatigue, include magnesium-rich foods like nuts, seeds, whole grains, and dark chocolate.',
                      'Hydration: Drink plenty of water to stay hydrated and reduce bloating.',
                    ],
                    moodTitle: 'Mood Management:',
                    moodContent:
                        'Mood swings during this phase are often caused by hormonal fluctuations (low estrogen and progesterone). This phase can bring about irritability and fatigue.',
                    moodTipsTitle: 'Self-Care Tips:',
                    moodTips: const [
                      'Rest and relax: Ensure adequate sleep and take time for self-care.',
                      'Herbal teas: Peppermint or ginger tea can help with cramps and mood stabilization.',
                      'Mindfulness and meditation: Practicing mindfulness can help manage stress and emotional imbalances.',
                    ],
                  ),

                  // Follicular Phase Section
                  _buildPhaseSection(
                    title: '2. Follicular Phase (Days 6-14)',
                    color: const Color.fromARGB(255, 192, 227, 255),
                    nutritionTitle: 'Nutritional Needs:',
                    nutritionContent:
                        'In the follicular phase, estrogen levels rise, and energy levels typically improve. Your body is gearing up for ovulation, so it\'s essential to provide it with fuel to support this increase in energy.',
                    foodsTitle: 'Foods to Include:',
                    foods: const [
                      'Protein: Lean proteins like chicken, turkey, and plant-based proteins (chickpeas, lentils) support muscle repair and provide energy.',
                      'Healthy fats: Avocados, nuts, seeds, and olive oil help balance hormones and support cognitive function.',
                      'Whole grains: Brown rice, oats, quinoa, and sweet potatoes provide steady energy.',
                      'Hydration: Focus on hydration to maintain good energy levels.',
                    ],
                    moodTitle: 'Mood Management:',
                    moodContent:
                        'Estrogen is rising, which can boost mood, energy, and cognitive function during this phase. However, some women may still experience anxiety or overthinking.',
                    moodTipsTitle: 'Self-Care Tips:',
                    moodTips: const [
                      'Physical activity: Light to moderate exercise can elevate endorphins and support a positive mood.',
                      'Mindful eating: Focus on nutrient-dense foods to support mood stability.',
                      'Cognitive techniques: Journaling or talking with friends can help alleviate anxiety.',
                    ],
                  ),

                  // Ovulation Phase Section
                  _buildPhaseSection(
                    title: '3. Ovulation Phase (Days 15-17)',
                    color: const Color.fromARGB(255, 208, 255, 185),
                    nutritionTitle: 'Nutritional Needs:',
                    nutritionContent:
                        'During ovulation, estrogen peaks, and your body is at its most fertile. Your energy is often at its highest point, so it\'s a good time to focus on foods that help maintain energy and keep your metabolism active.',
                    foodsTitle: 'Foods to Include:',
                    foods: const [
                      'High-protein snacks: Eggs, Greek yogurt, or nuts and seeds can help keep you full and energized.',
                      'B Vitamins: Whole grains, leafy greens, and legumes support the body\'s metabolism and energy production during this phase.',
                      'Zinc-rich foods: Pumpkin seeds, chickpeas, and cashews can support immune health during ovulation.',
                      'Hydration: Water is still essential to prevent bloating that may occur during ovulation.',
                    ],
                    moodTitle: 'Mood Management:',
                    moodContent:
                        'Estrogen\'s peak during ovulation is linked to increased mood stability and overall happiness, though some may still feel the tension of high-energy hormone changes.',
                    moodTipsTitle: 'Self-Care Tips:',
                    moodTips: const [
                      'Socialize: This is a good time to engage in social activities and connect with others.',
                      'Manage stress: Use breathing exercises or yoga to stay calm and focused.',
                    ],
                  ),

                  // Luteal Phase Section
                  _buildPhaseSection(
                    title: '4. Luteal Phase (Days 18-28)',
                    color: const Color.fromARGB(255, 255, 222, 179),
                    nutritionTitle: 'Nutritional Needs:',
                    nutritionContent:
                        'In the luteal phase, progesterone rises, preparing the body for potential pregnancy. This can often lead to symptoms like fatigue, bloating, and cravings, especially for sweets and salty snacks.',
                    foodsTitle: 'Foods to Include:',
                    foods: const [
                      'Complex carbs: Brown rice, sweet potatoes, oats, and whole wheat pasta can help stabilize blood sugar levels and reduce cravings.',
                      'Vitamin B6: Found in chicken, bananas, potatoes, and fortified cereals, B6 can reduce PMS symptoms and support mood balance.',
                      'Magnesium and calcium: Both can help alleviate bloating, cramps, and mood swings. Include foods like almonds, tofu, broccoli, and fortified dairy.',
                      'Hydration: Drink water regularly to prevent water retention and bloating.',
                    ],
                    moodTitle: 'Mood Management:',
                    moodContent:
                        'Progesterone dominance during the luteal phase can lead to mood swings, irritability, anxiety, and even depression. Managing these changes involves nutrition, exercise, and stress management techniques.',
                    moodTipsTitle: 'Self-Care Tips:',
                    moodTips: const [
                      'Exercise: Light to moderate exercise like walking, yoga, or swimming can help reduce anxiety.',
                      'Reduce stress: Try stress-relieving techniques like meditation or deep breathing.',
                      'Eat small, frequent meals: This can help maintain stable blood sugar levels.',
                    ],
                  ),

                  // Conclusion
                  _buildSectionHeader('Holistic Cycle Management'),
                  const SizedBox(height: 16),
                  const Text(
                    'By understanding how nutrition and mood swings evolve throughout the menstrual cycle, you can take a proactive approach to self-care. Adjusting your diet to support your body\'s changing needs and incorporating strategies to manage mood swings will help you feel more balanced and in control throughout the month.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: Color(0xFF5D5D5D),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5D5D5D),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildPhaseList() {
    return Column(
      children: [
        _buildPhaseListItem('Menstrual Phase (Days 1-5)',
            const Color.fromARGB(255, 255, 198, 219)),
        _buildPhaseListItem('Follicular Phase (Days 6-14)',
            const Color.fromARGB(255, 194, 215, 250)),
        _buildPhaseListItem('Ovulation Phase (Days 15-17)',
            const Color.fromARGB(255, 215, 248, 196)),
        _buildPhaseListItem('Luteal Phase (Days 18-28)',
            const Color.fromARGB(255, 255, 233, 194)),
      ],
    );
  }

  Widget _buildPhaseListItem(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF5D5D5D),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseSection({
    required String title,
    required Color color,
    required String nutritionTitle,
    required String nutritionContent,
    required String foodsTitle,
    required List<String> foods,
    required String moodTitle,
    required String moodContent,
    required String moodTipsTitle,
    required List<String> moodTips,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D5D5D),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            nutritionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D5D5D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            nutritionContent,
            style: const TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Color(0xFF5D5D5D),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            foodsTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D5D5D),
            ),
          ),
          const SizedBox(height: 8),
          ...foods
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: color.withOpacity(0.8),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Color(0xFF5D5D5D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              ,
          const SizedBox(height: 16),
          Text(
            moodTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D5D5D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            moodContent,
            style: const TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Color(0xFF5D5D5D),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            moodTipsTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D5D5D),
            ),
          ),
          const SizedBox(height: 8),
          ...moodTips
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: color.withOpacity(0.8),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Color(0xFF5D5D5D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              ,
        ],
      ),
    );
  }
}
