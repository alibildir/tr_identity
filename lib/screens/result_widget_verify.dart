import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ResultWidgetVerify extends StatelessWidget {
  final String resultString;
  final bool positive;
  const ResultWidgetVerify(this.resultString, this.positive, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(title: Text(AppLocalizations.of(context)!.helloWorld),
  ),
  body: Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(children: [
        Text(AppLocalizations.of(context)!.result,
          style: TextStyle(color: Colors.red, fontSize: 30),
        ),
        Flexible(
          child: Text(resultString,
            style: TextStyle(color: positive?Colors.blue:Colors.red, fontSize: 30),),
        )
      ]),
    ),
  ),
);
  }
  
}