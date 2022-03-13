import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ogrenme2/screens/input_widget_tc.dart';
import 'package:ogrenme2/screens/input_widget_person.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Ali Bildir';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('tr', ''), // Turkish, no country code
      ],
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.helloWorld),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Text(AppLocalizations.of(context)!.verify),
              ),
              Tab(
                icon: Text(AppLocalizations.of(context)!.agnate),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Center(
                  child: InputWidgetPerson(0),
                ),
                Center(
                  child: InputWidgetTc(1),
                ),
              ]),
            ),
          ],
        ));
  }
}
