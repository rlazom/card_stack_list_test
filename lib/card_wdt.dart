import 'dart:math' as math;
import 'package:flutter/material.dart';

class CardWdt extends StatelessWidget {
  final Widget child;
  final String text;
  final double percent;
  final bool up;

  const CardWdt(
      {Key? key,
      required this.child,
      this.percent = 0,
      this.up = false,
      this.text = '-'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    // final height = size.height - (16 * 2);
    // final width = size.width;
    // print('CardWdt - build() - text: "$text", width: "$width", height: "$height"');

    return SizedBox(
      // height: 173.3,
      child: Transform(
        alignment: up ? Alignment.topCenter : Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.003)
          ..rotateX((percent * (up ? 0.5 : 0.25)) * -math.pi),
        child: InkWell(
          onTap: () {},
          // onTap: () => print('card value: $value, text: $text'),
          child: AspectRatio(
            aspectRatio: 2,
            child: LayoutBuilder(builder: (context, constraints) {
              // print('CardWdt - build() - text: "$text", constraints: "$constraints"');

              const double borderRadius = 6.0;

              return Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.black],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2, 0.9],
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(4.0, 4.0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Stack(
                    children: [
                      child,
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.10),
                              Colors.black.withOpacity(0.20)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: const [0.2, 0.9],
                          ),
                        ),
                        // child: Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Container(color:Colors.white,child: Text(text),),
                        // ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
