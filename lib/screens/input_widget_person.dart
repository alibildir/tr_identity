import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ogrenme2/screens/result_widget_verify.dart';
import '../client/nvi_client.dart';
import '../business/tcvalidate.dart';

class InputWidgetPerson extends StatefulWidget {
  final int whichTab;

  const InputWidgetPerson(this.whichTab, {Key? key}) : super(key: key);

  @override
  State<InputWidgetPerson> createState() => _InputWidgetPersonState();
}

class _InputWidgetPersonState extends State<InputWidgetPerson> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final buttons = [
      AppLocalizations.of(context)!.verify,
      AppLocalizations.of(context)!.agnate
    ];
    String? queriedID = "";
    String? queriedName = "";
    String? queriedSurname = "";
    String? queriedBirthYear = "";
    String resultString = "";

    _getHintText(String keyName){
      String hintText="";
      switch (keyName) {
        case ("queriedID"):
          hintText=AppLocalizations.of(context)!.queriedID;
      break;
      case ("queriedName"):
      hintText=AppLocalizations.of(context)!.queriedName;
      break;
      case ("queriedSurname"):
      hintText=AppLocalizations.of(context)!.queriedSurname;
      break;
      case ("queriedBirthYear"):
      hintText=AppLocalizations.of(context)!.queriedBirthYear;
      break;
    }
      return hintText;
    }

    _buildFormFieldWith(String saveTo) {
      return TextFormField(
        decoration: InputDecoration(
        hintText: _getHintText(saveTo),
label: Text(_getHintText(saveTo)),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.validate_not_null;
          }
          switch (saveTo) {
            case ("queriedID"):
              if (!tcValidate().tcValidator(value)) {
                return AppLocalizations.of(context)!.validate_not_null;
              }
              break;
            case ("queriedName"):
            case ("queriedSurname"):
              if (value.length < 2) {
                return AppLocalizations.of(context)!.validate_not_null;
              }
              break;
            case ("queriedBirthYear"):
              if (!tcValidate().isYear(value)) {
                return AppLocalizations.of(context)!.validate_not_null;
              }
              break;
          }

          return null;
        },
        onSaved: (String? value) {
          switch (saveTo) {
            case ("queriedID"):
              queriedID = value;
              break;
            case ("queriedName"):
              queriedName = value;
              break;
            case ("queriedSurname"):
              queriedSurname = value;
              break;
            case ("queriedBirthYear"):
              queriedBirthYear = value;
              break;
          }
        },
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildFormFieldWith("queriedID"),
          _buildFormFieldWith("queriedName"),
          _buildFormFieldWith("queriedSurname"),
          _buildFormFieldWith("queriedBirthYear"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  List<dynamic> resultItems = await NviClient().makeARequest(
                      queriedID!,
                      queriedName!,
                      queriedSurname!,
                      queriedBirthYear!);
                  setState(() {
                    if (resultItems[1] == 200) {
                      resultString = resultItems[0] == "true"
                          ? AppLocalizations.of(context)!.verify_verified
                          : AppLocalizations.of(context)!.verify_not_verified;
                    } else {
                      resultString =
                      AppLocalizations.of(context)!.verify_technical_error;
                    }
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          ResultWidgetVerify(resultString,
                              ((resultItems[1] == 200)&&(resultItems[0] == "true"))))
                  );
                }
              },
              child: Text(buttons[widget.whichTab]),
            ),
          ),

        ],
      ),
    );
  }
}
