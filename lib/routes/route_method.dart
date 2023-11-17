//app file

import '../config.dart';
import 'route_name.dart';

RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.login, page: () =>  LoginScreen()),

  ];
}
