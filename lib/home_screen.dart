import 'dart:ui';

import 'package:flutter/material.dart';

import 'data.dart';
import 'logic/bloc.dart';
import 'widgets/background_widget.dart';
import 'widgets/footer_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/middle_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final myBLoC = MyBLoC();

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    myBLoC.init();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    myBLoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DataProvider(
      myBLoC: myBLoC,
      child: Builder(builder: (context) {
        final myBloc = DataProvider.of(context).myBLoC;
        double currentTranslate = 0.0;
        bool expanded = false;
        return Scaffold(
          body: AnimatedBuilder(
              animation: animationController,
              builder: (context, snapshot) {
                double curveValue =
                    Curves.easeInOut.transform(animationController.value);

                return GestureDetector(
                  onVerticalDragUpdate: (details) {
                    currentTranslate = myBloc.currentTranslate;
                    final newTranslateValue =
                        currentTranslate + details.delta.dy;
                    animationController.value = currentTranslate / size.height;
                    myBloc.setCurrentTranslate(
                        newTranslateValue.clamp(0.0, size.height));
                  },
                  onVerticalDragEnd: (details) {
                    expanded = myBloc.expanded;
                    if (!expanded) {
                      if (currentTranslate > size.height * .2) {
                        animationController.forward();
                        myBloc.setCurrentTranslate(size.height);
                        myBloc.setExpanded(true);
                      } else {
                        animationController.reverse();
                        myBloc.setCurrentTranslate(0.0);
                        myBloc.setExpanded(false);
                      }
                    } else {
                      if (currentTranslate > size.height * .8) {
                        animationController.forward();
                        myBloc.setCurrentTranslate(size.height);
                        myBloc.setExpanded(true);
                      } else {
                        animationController.reverse();
                        myBloc.setCurrentTranslate(0.0);
                        myBloc.setExpanded(false);
                      }
                    }
                  },
                  child: ValueListenableBuilder<double>(
                      valueListenable: myBloc.currentPage,
                      builder: (context, currentPage, child) {
                        final currentPageClamp = currentPage.clamp(0.0, 1.0);
                        Size size = MediaQuery.of(context).size;

                        return Stack(
                          children: [
// HEADER
                            Positioned(
                              top: lerpDouble(20, 0, curveValue),
                              left: lerpDouble(20, 0, curveValue),
                              right: lerpDouble(20, 0, curveValue),
                              height: lerpDouble(
                                  size.height * .20, size.height, curveValue),
                              child: SafeArea(
                                child: Opacity(
                                  opacity: (currentPageClamp -
                                          (1 - currentPageClamp))
                                      .clamp(0.0, 1.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (myBloc.expanded) {
                                        animationController.reverse(from: 1.0);
                                        myBloc.setCurrentTranslate(0.0);
                                        myBloc.setExpanded(false);
                                      } else {
                                        animationController.forward();
                                        myBloc.setCurrentTranslate(size.height);
                                        myBloc.setExpanded(true);
                                      }
                                    },
                                    child: HeaderWidget(
                                        animationValue: curveValue),
                                  ),
                                ),
                              ),
                            ),
// Footer
                            ValueListenableBuilder<double>(
                                valueListenable: myBloc.currentPage,
                                builder: (context, currentPage, child) {
                                  return Positioned(
                                    bottom:
                                        lerpDouble(0, -size.height, curveValue),
                                    left: 0,
                                    right: 0,
                                    child: SizedBox(
                                      height: size.height * .15,
                                      child: Opacity(
                                        opacity: (currentPageClamp -
                                                (1 - currentPageClamp))
                                            .clamp(0.0, 1.0),
                                        child: AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          reverseDuration:
                                              const Duration(milliseconds: 500),
                                          switchInCurve: Curves.ease,
                                          switchOutCurve: Curves.ease,
                                          transitionBuilder:
                                              (child, animation) =>
                                                  FadeTransition(
                                            opacity: animation,
                                            child: SlideTransition(
                                              position: Tween(
                                                begin: const Offset(0, 1),
                                                end: const Offset(0, 0),
                                              ).animate(animation),
                                              child: child,
                                            ),
                                          ),
                                          child: FooterWidget(
                                            key: Key(itemsFooter[(currentPage -
                                                        1 +
                                                        0.5)
                                                    .clamp(
                                                        0.0, itemsFooter.length)
                                                    .toInt()]
                                                .title),
                                            item: itemsFooter[(currentPage -
                                                    1 +
                                                    0.5)
                                                .clamp(0.0, itemsFooter.length)
                                                .toInt()],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
// BACKGROUND
                            ValueListenableBuilder<double>(
                                valueListenable: myBloc.currentPage,
                                builder: (context, currentPage, child) {
                                  return Positioned(
                                    top: size.height * .30 * (currentPageClamp),
                                    bottom:
                                        size.height * .23 * (currentPageClamp),
                                    left:
                                        size.width * 0.07 * (currentPageClamp),
                                    right:
                                        size.width * 0.16 * (currentPageClamp),
                                    child: Container(
                                      transform: Matrix4.identity()
                                        ..translate(
                                            (currentPage.clamp(1.0, 2.0) - 1) *
                                                -size.width *
                                                0.85,
                                            currentPage < 1
                                                ? 0.0
                                                : lerpDouble(
                                                    0,
                                                    size.height * .73,
                                                    curveValue)!),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withBlue(40),
                                        borderRadius: BorderRadius.circular(
                                            20 * currentPageClamp),
                                      ),
                                      child: Opacity(
                                        opacity: ((1 - currentPageClamp) -
                                                currentPageClamp * 2)
                                            .clamp(0.0, 1.0),
                                        child: const BackgroundWidget(),
                                      ),
                                    ),
                                  );
                                }),
// MIDDLE
                            Positioned(
                              top: lerpDouble(
                                  size.height * .25, size.height, curveValue),
                              height: size.height * .57,
                              left: (1 - currentPageClamp) * size.width * 0.9,
                              right: -(1 - currentPageClamp) * size.width * 0.9,
                              child: PageView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: myBloc.pageController,
                                itemCount: itemsMiddle.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return const SizedBox.shrink();
                                  }
                                  final item = itemsMiddle[index - 1];
                                  return Transform(
                                    transform: Matrix4.identity()
                                      ..translate((1 - currentPageClamp) *
                                          size.width *
                                          0.16)
                                      ..rotateZ((1 - currentPageClamp) / 8),
                                    child: Opacity(
                                      opacity: (currentPageClamp + 0.5)
                                          .clamp(0.0, 1.0),
                                      child: MiddleWidget(item: item),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                );
              }),
        );
      }),
    );
  }
}
