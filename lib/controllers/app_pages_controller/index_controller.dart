import 'package:chatzy_admin/config.dart';
import 'package:chatzy_admin/screens/report/report.dart';
import 'package:chatzy_admin/screens/wallpaper/wallpaper.dart';

class IndexController extends GetxController {

  ValueNotifier<bool> isOpen = ValueNotifier(true);
  GlobalKey<ScaffoldState>? scaffoldDrawerKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  int selectedIndex = 0;
  String pageName = fonts.dashboard;
  bool isHover = false;
  int isSelectedHover = 0;

  final ScrollController scrollController = ScrollController();

  //list of bottommost page
  List<Widget> widgetOptions = <Widget>[

    Dashboard(),
    UsageControlScreen(),
    UserAppSettingsScreen(),
    AdminStatusScreen(),
    WallPaper(),
    Report(),
    Container()
  ];

  @override
  void onReady() {
    // TODO: implement onReady
    appCtrl.getStorageData();
    super.onReady();
  }

}