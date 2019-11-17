import 'dart:html';
import 'dart:svg';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fx_crystal_ball/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exchange_model.dart';


class PredictScreen extends StatefulWidget {
  static const String id = 'predict_screen';

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;

  @override
  void initState(
      ) {
    super.initState(
    );

    getCurrentUser(
    );
  }

  void getCurrentUser(
      ) async {
    try {
      final user = await _auth.currentUser(
      );
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch (e) {
      print(
          e
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Predict();
  }
}



class Predict extends StatefulWidget {
  @override
  createState() => PredictState();
}

class PredictState extends State<Predict> {
  String currencyFrom = 'USD';
  String currencyTo = 'CAD';
  String thedate = '2019-11-10';
  String amount = '';
  String result = '';
  
  Future getPred(String currencyFrom, String currencyTo, String thedate) {
    
      var data = PredictModel.prediction(currencyFrom, currencyTo, thedate);
      var pred = data.predicted;
      
  }

  void iterateMapEntry(key, value) {
    updateResult((value * double.parse(amount)).toStringAsFixed(4));
  }

  void updateAmount(value) {
    setState(() {
      amount = value;
    });
  }

  void updateCurrencyFrom(value) {
    setState(() {
      currencyFrom = value;
      result = '';
    });
  }

  void updateCurrencyTo(value) {
    setState(() {
      currencyTo = value;
      result = '';
    });
  }

  void handleClick() {
    if (amount.length > 0) {
      getPred(currencyFrom, currencyTo, thedate);
    }
  }

  void updateResult(value) {
    setState(() {
      result = value;
    });
  }

  void goTo(page) {
    Navigator.pushNamed(context, '/$page');
  }

  @override
  Widget build(BuildContext context) {

    final currs = ['USD', 'CAD', 'BRL', 'CHF', 'CNY', 'CZK', 'HRK', 
      'IDR', 'INR', 'MXN', 'NZD', 'RON', 'RUB' ,'SGD', 'TRL', 'TRY', 'ZAR'];

    final currencies = [
      
      new DropdownMenuItem<String>(value: 'USD', child: Text('USD')),
      new DropdownMenuItem<String>(value: 'CAD', child: Text('CAD')),
      new DropdownMenuItem<String>(value: 'BRL', child: Text('BRL')),
      new DropdownMenuItem<String>(value: 'CHF', child: Text('CHF')),
      new DropdownMenuItem<String>(value: 'CNY', child: Text('CNY')),
      new DropdownMenuItem<String>(value: 'CZK', child: Text('CZK')),
      new DropdownMenuItem<String>(value: 'HRK', child: Text('HRK')),
      new DropdownMenuItem<String>(value: 'IDR', child: Text('IDR')),
      new DropdownMenuItem<String>(value: 'INR', child: Text('INR')),
      new DropdownMenuItem<String>(value: 'MXN', child: Text('MXN')),
      new DropdownMenuItem<String>(value: 'NZD', child: Text('NZD')),
      new DropdownMenuItem<String>(value: 'RON', child: Text('RON')),
      new DropdownMenuItem<String>(value: 'RUB', child: Text('RUB')),
      new DropdownMenuItem<String>(value: 'SGD', child: Text('SGD')),
      new DropdownMenuItem<String>(value: 'TRL', child: Text('TRL')),
      new DropdownMenuItem<String>(value: 'TRY', child: Text('TRY')),
      new DropdownMenuItem<String>(value: 'ZAR', child: Text('ZAR'))


    ].toList();

    Widget resultChild;

    if (result != '') {
      resultChild = Container(
        margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        decoration: BoxDecoration(color: Colors.black12),
        height: 50.0,
        alignment: Alignment(0.0, 0.0),
        child: Text(result, style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold
        )),
      );
    } else {
      resultChild = Container();
    }

    var textField = Row(
      children: [
        Expanded(
          child: TextField(
              decoration: InputDecoration(
                  labelText: 'Type amount'
              ),
              onChanged: (value) => updateAmount(value)
          ),
        )
      ],
    );

    var dropDowns = Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 20.0, 40.0, 0.0),
            child: DropdownButton(
              value: currencyFrom,
              items: currencies,
              onChanged: (value) {
                updateCurrencyFrom(value);
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
            child: DropdownButton(
              value: currencyTo,
              items: currencies,
              onChanged: (value) {
                updateCurrencyTo(value);
              },
            ),
          ),
        // Need something similar here to get the target date.
        // Expanded(
        //   child: Container(
        //     margin: EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
        //     child: DropdownButton(
        //       value: currencyTo,
        //       items: currencies,
        //       onChanged: (value) {
        //         updateCurrencyTo(value);
        //       },
        //     ),
        //   ),

        )
      ],
    );

    var message = Row(
      children: [
        Expanded(
            child: resultChild
        )
      ],
    );

    var button = Row(
      children: [
        Expanded(
            child: Container(
                child: RaisedButton(
                    child: Text('Calculate'),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
                    onPressed: () => handleClick()
                )
            )
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
            title: Text('Predict Exchange Rate'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () => goTo('credits')
              )
            ]
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                textField,
                dropDowns,
                message
              ],
            )
        ),
        bottomNavigationBar: button
    );
  }
}