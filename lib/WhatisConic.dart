import 'package:flutter/material.dart';
import 'package:math_app/Intro.dart';

class ConicCurvesPage extends StatelessWidget {
  const ConicCurvesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cone-Nic Curves',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
     
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE53E3E), Color(0xFFECC94B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.gesture,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome to Cone-Nic Curves',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'An innovative educational smartphone app',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // About Section
            _buildSectionCard(
              title: 'About the App',
              content: 'Cone-Nic Curves is designed to improve conic sections\' instruction and learning. This app fills the learning gap between abstract mathematical theory and interactive learner-centered experiences, addressing the challenges students face when visualizing and comprehending the geometric properties of conic curves.',
              icon: Icons.info_outline,
              color: const Color(0xFFE53E3E), // Red
            ),
            
            const SizedBox(height: 16),
            
            // Features Section
            _buildSectionCard(
              title: 'Interactive Features',
              content: 'Experience dynamic and interactive representations of circle, ellipse, parabola, and hyperbola formations through guided lessons, formula derivations, interactive graph manipulation, 3D visualizations, and integrated self-assessment quizzes.',
              icon: Icons.touch_app,
              color: const Color(0xFF38A169), // Green
            ),
            
            const SizedBox(height: 16),
            
            // Offline Access Section
            _buildSectionCard(
              title: 'Offline Learning',
              content: 'Designed exclusively as an offline app for enhanced accessibility on Android mobile devices, including older versions. Perfect for both classroom instruction and independent study.',
              icon: Icons.offline_bolt,
              color: const Color(0xFFEF4444),
            ),
            
            const SizedBox(height: 24),
            
            // Target Audience
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: const Color(0xFF4338CA), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4338CA).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.school,
                          color: Color(0xFF4338CA),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Perfect For Students',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Especially beneficial for students studying conic sections in Precalculus, Analytical Geometry, or related subjects. Supports diverse learning styles and makes mathematical concepts more accessible, engaging, and easier to understand.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Objectives Section
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main Objectives',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildObjectiveItem(
                    '1',
                    'Help students understand characteristics and properties of conic sections through interactive and visual learning.',
                  ),
                  _buildObjectiveItem(
                    '2',
                    'Simplify understanding of complex precalculus and analytical geometry ideas through simulations and guided lessons.',
                  ),
                  _buildObjectiveItem(
                    '3',
                    'Provide an offline learning platform for mobile devices enabling both self-study and classroom instruction.',
                  ),
                  _buildObjectiveItem(
                    '4',
                    'Increase student retention and engagement through interactive exercises and self-assessment resources.',
                  ),
                  _buildObjectiveItem(
                    '5',
                    'Increase accessibility of learning platforms for Android mobile users, especially older versions.',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Get Started Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  ConicSectionIntroPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Get Started Learning',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2F5F),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObjectiveItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:             Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}