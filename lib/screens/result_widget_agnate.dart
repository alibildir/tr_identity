import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../business/find_agnate.dart';

class ResultWidgetVerify extends StatefulWidget {
  final String queriedID;
  final List<String> familyTree;

  const ResultWidgetVerify(this.queriedID, this.familyTree,{Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _verifyTCResult(queriedID, familyTree);
  }
}

class _verifyTCResult extends State with SingleTickerProviderStateMixin {
  List<String> familyTree;
  String queriedID = "";

  _verifyTCResult(this.queriedID, this.familyTree);

  @override
  void initState() {
    super.initState();
    familyTree.insert(0, FindAgnate().firstAgnate(queriedID));
    familyTree.add(FindAgnate().lastAgnate(queriedID));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.agnate_result),
          ),
        body: Column(
          children: [
            Expanded(
              child:
                Center(
                  child: MyStatefulWidget(familyTree),
                ),
            ),
          ],
        ));
  }
}

Widget resultColumn(String queriedID) {
  return Column(
    children: [Text(resultFromWebServices(queriedID)), Text(queriedID)],
  );
}

String resultFromWebServices(String queriedID) {
  return FindAgnate().firstAgnate(queriedID);
}

class MyStatefulWidget extends StatefulWidget {
  final List<String> familyTree;
  const MyStatefulWidget(this.familyTree, {Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState(familyTree);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<String> familyTree;
  final ScrollController _firstController = ScrollController();

  _MyStatefulWidgetState(this.familyTree);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: <Widget>[
          SizedBox(
              width: constraints.maxWidth,
              // This vertical scroll view has not been provided a
              // ScrollController, so it is using the
              // PrimaryScrollController.
              child: Scrollbar(
                isAlwaysShown: true,
                child: ListView.builder(
                    itemCount: (familyTree.length + 2),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          alignment: Alignment.center,
                          height: 50,
                          color: index.isEven ?
                                Colors.white
                              : Colors.blue[100],
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: index == 0
                                  ? (TextButton.icon(
                                      onPressed: () {
                                        familyTree.insert(
                                            0,
                                            FindAgnate()
                                                .firstAgnate(familyTree[0]));
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.upload_rounded),
                                      label: Text(AppLocalizations.of(context)!.elder),
                                    ))
                                  : index == familyTree.length + 1
                                      ? (TextButton.icon(
                                          onPressed: () {
                                            familyTree.add(FindAgnate()
                                                .lastAgnate(familyTree[
                                                    familyTree.length - 1]));
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.download_rounded),
                                          label: Text(AppLocalizations.of(context)!.younger),
                                        ))
                                      : (Text(familyTree[index - 1]))));
                    }),
              )),
        ],
      );
    });
  }
}


