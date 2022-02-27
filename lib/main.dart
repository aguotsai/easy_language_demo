import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    child: const MyApp(),
    // 支援的語言
    supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
    // 語言資源包目錄
    path: 'resources/langs',
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 國際化: 多語言處理',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hi, test 3 國際化!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            child: Text(tr("cur_lang")),
            alignment: Alignment.center,
          ),
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () => showChangeLanguageDialog(),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tr("title"),
              // 加大字型, 便於演示
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  void showChangeLanguageDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            //title: Text("Language"),
            title: Text(tr("language")),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("中文"),
                onPressed: () {
                  context.setLocale(Locale('zh', 'CN'));
                  //EasyLocalization.of(context).locale = Locale('zh', 'CN');
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text("English"),
                onPressed: () {
                  context.setLocale(Locale('en', 'US'));
                  //EasyLocalization.of(context).locale = Locale('en', 'US');
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
