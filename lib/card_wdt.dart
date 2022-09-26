import 'dart:math' as math;
import 'package:flutter/material.dart';

class CardWdt extends StatelessWidget {
  final String value;
  final String text;
  final double percent;
  final bool up;
  final bool down;

  const CardWdt(
      {Key? key,
        required this.value,
        required this.percent,
        this.down = true,
        this.up = false,
        this.text = '-'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.003)
          ..rotateX((percent * (up ? 0.5 : 0.25)) * -math.pi),
        child: InkWell(
          onTap: () => print('card value: $value, text: $text'),
          child: AspectRatio(
            aspectRatio: 1.8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(4.0, 4.0),
                  ),
                ],
              ),

              // width: double.infinity,
              // height: 100,
              // width: 200,
              child: Center(child: Text(value)),
            ),
          ),
        ),
      ),
    );
  }
}