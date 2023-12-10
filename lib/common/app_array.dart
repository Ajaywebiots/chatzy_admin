
import '../config.dart';

class AppArray{
  //language list
  var languageList = [
    {'name': 'english', 'locale': const Locale('en', 'US')},
    {'name': 'arabic', 'locale': const Locale('ar', 'AE')},
    {'name': 'hindi', 'locale': const Locale('hi', 'IN')},
    {'name': 'korean', 'locale': const Locale('ko', 'KR')}
  ];

  //action list
  var actionList = [
    {'title': "english"},
    {'title': "hindi"},
    {'title': "korean"},
    {'title': "arabic"},
  ];

  //Drawer list
  var drawerList = [
    {'icon': svgAssets.dashboard1, 'title': "dashboard",'icon1': svgAssets.dashboard},
    {'icon': svgAssets.usageControl, 'title': "usageControl",'icon1': svgAssets.usageControl1},
    {'icon': svgAssets.appControl, 'title': "appSetting",'icon1': svgAssets.appControl1},
    {'icon': svgAssets.status, 'title': "sponsor",'icon1': svgAssets.status1},
    {'icon': svgAssets.gallery, 'title': "wallpaper",'icon1': svgAssets.gallery},
    {'icon': svgAssets.dislike, 'title': "report",'icon1': svgAssets.dislike},
    {'icon': svgAssets.logout, 'title': "logout",'icon1': svgAssets.logout1},
  ];

}