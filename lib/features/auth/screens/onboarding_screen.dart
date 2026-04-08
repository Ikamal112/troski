import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: 'Welcome to Troski',
      description: 'Navigate Accra’s hustle with real-time updates and shared rides.',
      image: 'assets/images/onboarding3.png',
      highlightedWord: 'Troski',
    ),
    OnboardingData(
      title: 'Connect with Drivers',
      description: 'Say goodbye to long waits. See live locations of Troskis around you and book your spot instantly.',
      image: 'assets/images/onboarding1.png',
    ),
    OnboardingData(
      title: 'Simplify Group Travel',
      description: 'No need to split up. Select a leader, request a single ride for your whole group, and get moving faster.',
      image: 'assets/images/onboarding2.png',
      highlightedWord: 'Group',
    ),
  ];

  void _onNextPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Final page reached, navigate to Role Selection or Signup
      _navigateToAuth();
    }
  }

  void _onSkipPressed() {
    _navigateToAuth();
  }

  void _navigateToAuth() {
    // For now, we'll just print, but this is where we'd go to the next screen
    debugPrint('Navigate to Auth Flow');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: TextButton(
                  onPressed: _onSkipPressed,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.primaryRed,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingContent(
                    data: _onboardingData[index],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? AppColors.primaryRed : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryRed,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to login
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: AppColors.primaryRed,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String image;
  final String? highlightedWord;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
    this.highlightedWord,
  });
}

class OnboardingContent extends StatelessWidget {
  final OnboardingData data;

  const OnboardingContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image Placeholder
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIconForData(),
                    size: 100,
                    color: AppColors.primaryYellow,
                  ),
                  if (data.highlightedWord == 'Group')
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "GROUP SIZE\n4 People",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Title with potential highlighting
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              children: _buildTitleSpans(),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForData() {
    if (data.highlightedWord == 'Group') return Icons.group;
    if (data.highlightedWord == 'Troski') return Icons.map;
    return Icons.directions_bus;
  }

  List<TextSpan> _buildTitleSpans() {
    if (data.highlightedWord == null) {
      return [TextSpan(text: data.title)];
    }

    final parts = data.title.split(data.highlightedWord!);
    List<TextSpan> spans = [];
    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: data.highlightedWord,
          style: const TextStyle(color: AppColors.primaryRed),
        ));
      }
    }
    return spans;
  }
}
