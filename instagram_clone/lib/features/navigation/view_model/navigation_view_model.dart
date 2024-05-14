import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  late PageController _pageController;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;

  void init() {
    _pageController = PageController(initialPage: 0);
  }

  void onPageChanged(int page) {
    _currentIndex = page;
    notifyListeners();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
