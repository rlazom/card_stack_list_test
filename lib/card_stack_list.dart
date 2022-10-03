import 'dart:math' as math;
import 'dart:ui';

// import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'card_wdt.dart';

class CardStackList extends StatelessWidget {
  final List cardList;
  final int cardStackNumber;
  final GlobalKey stickyKey = GlobalKey();
  final currentTrendingMovieIdNotifier = ValueNotifier<double>(0.0);
  final PageController controller = PageController(
    viewportFraction: 1,
    keepPage: true,
    initialPage: 0,
  );

  CardStackList({super.key, required this.cardList, this.cardStackNumber = 1}) {
    controller.addListener(_pageListener);
  }

  void _pageListener() {
    currentTrendingMovieIdNotifier.value =
        controller.page ?? controller.initialPage.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxHeight = constraints.maxHeight;
      final maxWidth = constraints.maxWidth;
      final min = math.min(maxHeight, maxWidth);
      // print('min: "$min"');

      return Column(
        children: [
          Expanded(
            child: Stack(
              children: <Widget>[
                ValueListenableBuilder<double>(
                    valueListenable: currentTrendingMovieIdNotifier,
                    builder: (context, currentIndexValue, _) {
                      int index = currentIndexValue.floor();
                      double percent = (currentIndexValue - index).abs();

                      //////////////////////////////////////
                      // String value = cardList.elementAt(index);
                      //////////////////////////////////////

                      // if (kDebugMode) {
                      //   print('currentIndexValue: $currentIndexValue, '
                      //       'index: $index, '
                      //       '_percent: $percent, ');
                      // }

                      // int bottomMaxStackOfCards = 4;
                      int bottomMaxStackOfCards = cardStackNumber;
                      // double stackOfCardsPadding = 0.02;
                      double stackOfCardsPadding = 16.0;
                      // const double horizontalPaddingOnStack = 12;
                      // final double horizontalPaddingOnStack = 7.5 * min / 100;
                      // print('horizontalPaddingOnStack: "$horizontalPaddingOnStack"');

                      final double distanceBetweenCurrentStack = 4 * min / 100;
                      // print('distanceBetweenCurrentStack: "$distanceBetweenCurrentStack"');

                      List<Widget> stackOfCards = [];

                      const double topCardOpacityFrom = 0.90;

                      /// Current Card
                      stackOfCards.add(Transform.translate(
                        offset: Offset(
                            0, lerpDouble(0, -stackOfCardsPadding, percent)!),
                        child: Opacity(
                          opacity: percent < topCardOpacityFrom
                              ? 1
                              : 1 -
                                  (percent - topCardOpacityFrom) /
                                      (1 - topCardOpacityFrom),
                          child: CardWdt(
                            key: stickyKey,
                            up: true,
                            child: cardList.elementAt(index),
                            percent: -percent,
                          ),
                        ),
                      ));

                      ////////////////////////////////////////////////////////////
                      final keyContext = stickyKey.currentContext;
                      final renderObject = keyContext?.findRenderObject();

                      double cardWdtHeight = min / 2 - 16;
                      // double cardWdtWidth = cardWdtHeight*2;
                      // print('CardStackList - CardWidget(null) - cardWdtHeight: "$cardWdtHeight", cardWdtWidth: "$cardWdtWidth"');

                      if (renderObject != null) {
                        final box = renderObject as RenderBox;
                        cardWdtHeight = box.size.height;
                        // cardWdtWidth = box.size.width;

                        // print('CardStackList - CardWidget(renderObject) - cardWdtHeight: "$cardWdtHeight", cardWdtWidth: "$cardWdtWidth"');
                      }

                      double posIni =
                          cardWdtHeight + distanceBetweenCurrentStack;
                      double posEnd = 0.0;
                      ////////////////////////////////////////////////////////////

                      /// BOTTOM CARDS
                      for (int i = 1; i <= bottomMaxStackOfCards; i++) {
                        // print('i: "$i", posIni: "$posIni", posEnd: "$posEnd"');

                        if (index < cardList.length - i) {
                          stackOfCards.add(Transform.scale(
                            scale:
                                i == 1 ? lerpDouble(0.85, 1, percent)! : 0.85,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: lerpDouble(posIni, posEnd, percent)!,
                                bottom: i != bottomMaxStackOfCards ? 0 : lerpDouble(0,posIni-posEnd, percent)!,
                                // bottom: cardWdtHeight + (posIni + stackOfCardsPadding) - lerpDouble(posIni, posEnd, percent)!,
                              ),
                              child: CardWdt(
                                child: cardList.elementAt(index + i),
                                percent: i == 1 ? 1 - percent : 1,
                                // percent: 0,
                                text: '$index',
                              ),
                            ),
                          ));

                          // if (i == bottomMaxStackOfCards) {
                          //   stackOfCards.add(SizedBox(
                          //     height: cardWdtHeight + (posIni + stackOfCardsPadding) - lerpDouble(posIni, posEnd, percent)!,
                          //   ));
                          // }
                        } else {
                          stackOfCards.add(SizedBox(
                              height: cardWdtHeight +
                                  (posIni + stackOfCardsPadding)));
                        }
                        posEnd = posIni;
                        posIni = posEnd + stackOfCardsPadding;
                      }

                      /// BOTTOM - LAST card
                      if (index <
                          cardList.length - (bottomMaxStackOfCards + 1)) {
                        // stackOfCards.add(Transform.scale(
                        //   scale: 0.89,
                        //   child: Padding(
                        //     padding: EdgeInsets.only(
                        //       top: lerpDouble((posIni + stackOfCardsPadding),
                        //           posEnd, percent)!,
                        //       // top: lerpDouble(posIni, posEnd, percent)!,
                        //       bottom: ((posIni + stackOfCardsPadding)) -
                        //           lerpDouble((posIni + stackOfCardsPadding),
                        //               posEnd, percent)!,
                        //     ),
                        //     child: Opacity(
                        //       opacity: lerpDouble(0, 1, percent)!,
                        //       child: CardWdt(
                        //         child: cardList.elementAt(index + 3),
                        //         percent: 1,
                        //         text: '$index',
                        //       ),
                        //     ),
                        //   ),
                        // ));
                        // double kbottom = (cardWdtHeight + 4 + (posEnd + stackOfCardsPadding)) - lerpDouble((posIni + stackOfCardsPadding), posEnd, percent)! - 144;
                        stackOfCards.add(Transform.translate(
                          offset: Offset(
                              0,
                              lerpDouble(posIni + stackOfCardsPadding,
                                      posEnd - stackOfCardsPadding, percent)! -
                                  0.15),
                          // offset: Offset(0, (posIni + stackOfCardsPadding)),      /// POSICION INICIAL
                          // offset: Offset(0, (posEnd - stackOfCardsPadding)),   /// POSICION FINAL
                          // offset: Offset(0, 0),
                          child: Transform.scale(
                            scale: 0.85,
                            child: Opacity(
                              opacity: lerpDouble(0, 1, percent)!,
                              // opacity: 1,
                              child: CardWdt(
                                child: cardList
                                    .elementAt(bottomMaxStackOfCards + 1),
                                percent: 1,
                                // percent: 0,
                                text: '$index',
                                // text: 'bottom',
                              ),
                            ),
                          ),
                        ));
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          color: Colors.red,
                          child: Stack(
                              alignment: Alignment.topCenter,
                              children: stackOfCards.reversed.toList()),
                        ),
                      );
                    }),
                PageView.builder(
                    itemCount: cardList.length,
                    scrollDirection: Axis.vertical,
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      // String value = cardList.elementAt(index);

                      return InkWell(
                        onTap: () {
                          print('index: $index');
                        },
                        // child: CardWdt(value: value),
                        child: const SizedBox.shrink(),
                      );
                    })
              ],
            ),
          ),
        ],
      );
    });
  }
}
