import 'dart:math';

import 'package:cards_app/card_stack_list.dart';
import 'package:cards_app/cards_ui/card_metropolitano_wdt.dart';
import 'package:cards_app/enums.dart';
import 'package:cards_app/extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String appName = 'Flutter Card Stack List Demo';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> cardList = [];
  Random random = Random();

  @override
  void initState() {
    final int max = int.parse('1'.padRight(8,'0'));
    // int randomNumber = random.nextInt(max)+max;
    // print('max: "$max", max.length: ${max.toString().length}, randomNumber: "$randomNumber" - randomNumber.length: ${randomNumber.toString().length}');

    for(int i=0; i<10; i++) {
      int randomNumber1 = random.nextInt(max)+max;
      int randomNumber2 = random.nextInt(max)+max;

      Map<String, dynamic> valueMap = {
        'type': CardType.metropolitano,
        'currency': Currency.usd,
        'holder': 'NAME LAST NAME',
        'number': '$randomNumber1$randomNumber2',
        'expiry_date': '11/30'
      };
      cardList.add(valueMap);
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // color: Colors.amber,
            // height: 400,
            // width: 200,
            child: CardStackList(
              cardList: cardList.map((e) {
                return CardUiWdt(
                  holder: e['holder'],
                  type: e['type'],
                  currency: e['currency'],
                  number: e['number'],
                  expiryDate: e['expiry_date'],
                );
              }).toList(),
              cardStackNumber: 4,
            ),
          ),
        ),
      ),
    );
  }
}

class CardUiWdt extends StatelessWidget {
  final CardType type;
  final Currency? currency;
  final String number;
  final String holder;
  final String? cvv;
  final String expiryDate;

  const CardUiWdt({
    Key? key,
    required this.type,
    this.currency,
    required this.number,
    required this.holder,
    this.cvv,
    required this.expiryDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedNumber = number;
    var i = 0;
    final dashes = {1, 2, 3, 4};
    formattedNumber = formattedNumber.splitMapJoin(RegExp('....'),
        onNonMatch: (s) => dashes.contains(i++) ? ' ' : '');
    formattedNumber = formattedNumber.substring(0, formattedNumber.length - 1);

    if (type == CardType.metropolitano) {
      return CardMetropolitanoWdt(
        number: formattedNumber,
        currency: currency,
        holder: holder,
        expiryDate: expiryDate,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Colors.grey],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.2, 0.9],
          ),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(4.0, 4.0),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(formattedNumber),
                  ),
                ),
              ),
              Text(holder.toUpperCase()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(currency.toString().toShortString().toUpperCase()),
                  Text(expiryDate),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
