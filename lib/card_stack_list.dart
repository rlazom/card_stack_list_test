import 'dart:math' as math;
import 'dart:ui';

// import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'card_wdt.dart';

class CardStackList extends StatelessWidget {
  final List cardList;
  final int cardStackNumber;
  final double stackOfCardsPadding;
  final GlobalKey stickyKey = GlobalKey();
  final currentTrendingMovieIdNotifier = ValueNotifier<double>(0.0);
  final PageController controller = PageController(
    viewportFraction: 1,
    keepPage: true,
    initialPage: 0,
  );

  CardStackList({
    super.key,
    required this.cardList,
    this.cardStackNumber = 1,
    this.stackOfCardsPadding = 16.0,
  }) {
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

                      final double distanceBetweenCurrentAndStack =
                          4 * min / 100;
                      // print('distanceBetweenCurrentAndStack: "$distanceBetweenCurrentAndStack"');

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
                          child: InkWell(
                            onTap: () {
                              print('CURRENT');
                            },
                            child: CardWdt(
                              key: stickyKey,
                              up: true,
                              child: cardList.elementAt(index),
                              percent: -percent,
                            ),
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
                          cardWdtHeight + distanceBetweenCurrentAndStack;
                      double posEnd = 0.0;
                      ////////////////////////////////////////////////////////////

                      /// BOTTOM CARDS
                      for (int i = 1; i <= cardStackNumber; i++) {
                        if (index < cardList.length - i) {
                          stackOfCards.add(Transform.scale(
                            scale:
                                i == 1 ? lerpDouble(0.85, 1, percent)! : 0.85,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: lerpDouble(posIni, posEnd, percent)!,
                              ),
                              child: CardWdt(
                                child: cardList.elementAt(index + i),
                                percent: i == 1 ? 1 - percent : 1,
                                // percent: 0,
                                text: '$index',
                              ),
                            ),
                          ));
                        }
                        posEnd = posIni;
                        posIni = posEnd + stackOfCardsPadding;
                      }
                      stackOfCards.add(SizedBox(
                        height: cardWdtHeight + (posEnd + stackOfCardsPadding),
                      ));

                      /// BOTTOM - LAST card
                      if (index < cardList.length - (cardStackNumber + 1)) {
                        stackOfCards.add(Transform.translate(
                          // offset: Offset(0, lerpDouble(posIni + stackOfCardsPadding, posEnd - stackOfCardsPadding, percent)! - 1.00),
                          offset: Offset(
                              0,
                              lerpDouble(posIni + stackOfCardsPadding,
                                  posEnd - stackOfCardsPadding, percent)!),
                          child: Transform.scale(
                            scale: 0.85,
                            child: Opacity(
                              opacity: lerpDouble(0, 1, percent)!,
                              // opacity: 1,
                              child: CardWdt(
                                child: cardList.elementAt(cardStackNumber + 1),
                                percent: 1,
                                // percent: 0,
                                text: '$index',
                              ),
                            ),
                          ),
                        ));
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          // color: Colors.red,
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
                        onTap: (){
                          print('index: $index');
                          controller.animateToPage(index + 1,
                              duration:
                              const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const SizedBox.shrink(),
                        // child: Container(
                        //   color: Colors.blue,
                        //   width: 20,
                        //   height: 20,
                        // ),
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
