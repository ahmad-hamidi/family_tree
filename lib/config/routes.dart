import 'package:auto_route/annotations.dart';
import 'package:family_tree/screen/family_detail_screen.dart';
import 'package:family_tree/screen/home_screen.dart';
import 'package:family_tree/screen/not_found_screen.dart';
import 'package:family_tree/screen/profile_detail_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(page: FamilyDetailScreen, path: "/family-detail/:familyId"),
    AutoRoute(page: ProfileDetailScreen, path: "/profile/:familyId"),
    AutoRoute(page: NotFoundScreen, path: "*"),
  ],
)
class $Routes {}