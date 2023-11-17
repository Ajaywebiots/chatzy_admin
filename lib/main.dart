import 'dart:developer';
import 'dart:ui';
import 'package:chatzy_admin/routes/index.dart';
import 'common/language/index.dart';
import 'config.dart';
import 'package:universal_html/html.dart' as html;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391
  GetStorage.init();
  Get.put(AppController());
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD2twjo6eAruX2qh0e4LEAOF7ntP-HHuzE",
        authDomain: "chatzy-d4377.firebaseapp.com",
        projectId: "chatzy-d4377",
        storageBucket: "chatzy-d4377.appspot.com",
        messagingSenderId: "578973927253",
        appId: "1:578973927253:web:a5779e8204f083e1eb91dc",
        measurementId: "G-ZWTM754NT9"

       ),

  );


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var scaffoldDrawerKey = GlobalKey<ScaffoldState>(debugLabel: "drawer");
  var scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "key2");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    appCtrl.isLogin = html.window.localStorage[session.isLogin] ?? "false";
    log(appCtrl.isLogin);
    return GetMaterialApp(
      builder: (context, widget) {
        return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {

              return !snapshot.hasData ? MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              ) : LoginScreen();
            }
        );
      },
      debugShowCheckedModeBanner: false,
      translations: Language(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      // tran
      title: fonts.chatzyAdmin.tr,
      home: appCtrl.isLogged == true ? IndexLayout(scaffoldDrawerKey: scaffoldDrawerKey,scaffoldKey: scaffoldKey) : LoginScreen(),
      getPages: appRoute.getPages,
      theme: AppTheme.fromType(ThemeType.light).themeData,
      darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
      themeMode: ThemeService().theme,
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
