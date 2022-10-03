import 'package:cards_app/constants.dart';
import 'package:cards_app/enums.dart';
import 'package:cards_app/extensions.dart';
import 'package:cards_app/widgets/triangle_painter.dart';
import 'package:flutter/material.dart';

class CardMetropolitanoWdt extends StatelessWidget {
  final String number;
  final Currency? currency;
  final String holder;
  final String? cvv;
  final String expiryDate;

  const CardMetropolitanoWdt({
    Key? key,
    required this.number,
    this.currency,
    required this.holder,
    this.cvv,
    required this.expiryDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: R.colors.bankMetropolitanoGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// CARD TOP ROW (BANK NAME)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: Container(
                decoration: BoxDecoration(
                    color: R.colors.bankMetropolitanoGreen,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(16))),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: SizedBox(
                        width: 40,
                        height: 35,
                        child: Image.asset(
                          'assets/metropolitano.png',
                          fit: BoxFit.fitWidth,
                          // fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 3.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Banco Metropolitano',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Text(
                      'S.A.',
                      style: TextStyle(fontSize: 11.0),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// CARD NUMBER
          Expanded(
            child: Row(
              children: [
                Transform.translate(
                  offset: const Offset(20, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CustomPaint(
                      painter: TrianglePainter(
                        strokeColor: R.colors.bankMetropolitanoGreen,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: const SizedBox(
                        height: double.infinity,
                        width: 7,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(number),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// CARD HOLDER, EXPIRY DATE
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.only(left: 24.0, right: 16.0, bottom: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// CARD HOLDER
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          const SizedBox(width: 12.0,),
                          Text(
                            holder.toUpperCase(),
                          ),
                        ],
                      )),

                  /// EXPIRY DATE
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  if(currency != null)
                                    Text(currency.toString().toShortString().toUpperCase()),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('VENCE: $expiryDate'),
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Válida solo en Cuba - Uso electrónico exclusivo',
                                          style: TextStyle(fontSize: 9.0),
                                        )),
                                  )),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Container(
                            width: 40,
                            height: 30,
                            color: Colors.white,
                            child: Image.asset(
                              'assets/redsa.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}