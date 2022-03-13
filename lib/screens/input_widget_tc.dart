import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'result_widget_agnate.dart';
import '../business/tcvalidate.dart';

class InputWidgetTc extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final int whichTab;

  InputWidgetTc(this.whichTab, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = [
      AppLocalizations.of(context)!.verify,
      AppLocalizations.of(context)!.agnate
    ];
    String? queriedID;
    final List<String> familyTree = [];

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: (AppLocalizations.of(context)!.queriedID),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.validate_not_null;
              }
              if (!tcValidate().tcValidator(value)) {
                return AppLocalizations.of(context)!.validate_not_null;
              }
              return null;
            },
            onSaved: (String? value) {
              queriedID = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                  _formKey.currentState!.save();
                  familyTree.clear();
                  familyTree.add(queriedID!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultWidgetVerify(
                              queriedID!, familyTree)));
                }
              },
              child: Text(buttons[whichTab]),
            ),
          ),
        ],
      ),
    );
  }
}

