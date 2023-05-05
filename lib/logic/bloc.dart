import 'package:flutter/material.dart';

class MyBLoC {
  final pageController = PageController(viewportFraction: 0.85, initialPage: 1);

  final currentPage = ValueNotifier<double>(1.0);
  double currentPageClamp = 1.0;
  double currentTranslate = 0.0;

  bool expanded = false;

  void setCurrentTranslate(double newValue) {
    currentTranslate = newValue;
  }

  void setExpanded(bool newValue) {
    expanded = newValue;
  }

  void pageListener() {
    currentPage.value = pageController.page!;
    currentPageClamp = currentPage.value.clamp(0.0, 1.0);
  }

  void init() {
    currentPage.value = 1.0;
    pageController.addListener(pageListener);
  }

  void dispose() {
    pageController.removeListener(pageListener);
    pageController.dispose();
  }
}

class DataProvider extends InheritedWidget {
  final MyBLoC myBLoC;

  const DataProvider({
    super.key,
    required Widget child,
    required this.myBLoC,
  }) : super(child: child);

  static DataProvider of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<DataProvider>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
