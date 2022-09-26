import 'dart:ui';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'card_wdt.dart';

class CardStackList extends StatelessWidget {
  final List<String> cardList;
  final currentTrendingMovieIdNotifier = ValueNotifier<double>(0.0);
  final PageController controller = PageController(
    viewportFraction: 1,
    keepPage: true,
    initialPage: 0,
  );

  CardStackList({super.key, required this.cardList}) {
    controller.addListener(_pageListener);
  }

  void _pageListener() {
    currentTrendingMovieIdNotifier.value =
        controller.page ?? controller.initialPage.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - (16 * 2);

    return Column(
      children: [
        Expanded(
          child: Stack(
            // alignment: Alignment.center,
            children: <Widget>[
              ValueListenableBuilder<double>(
                  valueListenable: currentTrendingMovieIdNotifier,
                  builder: (context, currentIndexValue, _) {
                    int index = currentIndexValue.floor();
                    double percent = (currentIndexValue - index).abs();

                    //////////////////////////////////////
                    // String value = cardList.elementAt(index);
                    //////////////////////////////////////

                    if (kDebugMode) {
                      print('currentIndexValue: $currentIndexValue, '
                          'index: $index, '
                          '_percent: $percent, ');
                    }
                    int bottomMaxStackOfCards = 4;
                    double stackOfCardsPadding = 0.02;
                    // double stackOfCardsPadding = 16.0;
                    List<Widget> stackOfCards = [];

                    double posIni = .15;
                    double posEnd = 0.0;
                    const double topCardOpacityFrom = 0.90;

                    /// Current Card
                    stackOfCards.add(Transform.translate(
                      // offset: Offset(0, lerpDouble(height * posEnd, height * -0.08, percent)!),
                      offset: Offset(0, lerpDouble(height * posEnd, height * -0.125, percent)!),
                      child: Transform.scale(
                        scale: lerpDouble(1, 1, percent),
                        alignment: Alignment.topCenter,
                        child: Opacity(
                          opacity: percent < topCardOpacityFrom
                              ? 1
                              : 1 -
                              (percent - topCardOpacityFrom) /
                                  (1 - topCardOpacityFrom),
                          child: CardWdt(
                            up: true,
                            value: cardList.elementAt(index),
                            percent: -percent,
                          ),
                        ),
                      ),
                    ));

                    /// BOTTOM CARDS
                    for (int i = 1; i <= bottomMaxStackOfCards; i++) {
                      // print('i: "$i", posIni: "$posIni", posEnd: "$posEnd"');

                      double ini = height * posIni;
                      double end = height * posEnd;
                      // double ini = posIni;
                      // double end = posEnd;
                      // print('ini: "$ini", end: "$end"');
                      if (index < cardList.length - i) {
                        // stackOfCards.add(
                        //     Transform.translate(
                        //       offset: Offset(0, lerpDouble(ini, end, percent)!),
                        //       child: CardWdt(
                        //         value: cardList.elementAt(index + i),
                        //         percent: i == 1 ? 1-percent : 1,
                        //         index: index ,
                        //       ),
                        //     )
                        // );
                        stackOfCards.add(Padding(
                          padding: EdgeInsets.only(top: lerpDouble(ini, end, percent)!),
                          child: CardWdt(
                            value: cardList.elementAt(index + i),
                            percent: i == 1 ? 1 - percent : 1,
                            text: '$index',
                          ),
                        ));

                        // posEnd = posIni;
                        // posIni = posEnd + stackOfCardsPadding;
                      } else {
                        // SizedBox(height: 100 + height * (posIni + stackOfCardsPadding))
                        stackOfCards.add(
                          // SizedBox(height: 100 + height * (posIni + stackOfCardsPadding))
                            SizedBox(height: 100 + height*stackOfCardsPadding)
                            // SizedBox(height: 100 + stackOfCardsPadding)
                        );
                      }
                      posEnd = posIni;
                      posIni = posEnd + stackOfCardsPadding;
                    }

                    /// BOTTOM - LAST card
                    if (index < cardList.length - (bottomMaxStackOfCards + 1)) {
                      // stackOfCards.add(
                      //     Transform.translate(
                      //       offset: Offset(0, lerpDouble(height * (posIni + stackOfCardsPadding), height * posEnd, percent)!),
                      //       child: Opacity(
                      //         opacity: lerpDouble(0, 1, percent)!,
                      //         child: CardWdt(
                      //           value: cardList.elementAt(index + 3),
                      //           percent: 1,
                      //           index: index,
                      //         ),
                      //       ),
                      //     )
                      // );
                      stackOfCards.add(Padding(
                        padding: EdgeInsets.only(
                          top: lerpDouble(height * (posIni + stackOfCardsPadding), height * posEnd, percent)!,
                          bottom: (height * (posIni + stackOfCardsPadding))-lerpDouble(height * (posIni + stackOfCardsPadding), height * posEnd, percent)!,
                        ),
                        child: Opacity(
                          opacity: lerpDouble(0, 1, percent)!,
                          child: CardWdt(
                            value: cardList.elementAt(index + 3),
                            percent: 1,
                            // text: '$index',
                            text: '${lerpDouble(height * (posIni + stackOfCardsPadding), height * posEnd, percent)!}',
                          ),
                        ),
                      ));
                    } else {
                      stackOfCards.add(
                          SizedBox(height: 100 + height * (posIni + stackOfCardsPadding))
                      );
                    }

                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        color: Colors.red,
                        child: Stack(
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
  }
}
