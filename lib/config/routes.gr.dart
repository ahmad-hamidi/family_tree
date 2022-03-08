// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../screen/family_detail_screen.dart' as _i2;
import '../screen/home_screen.dart' as _i1;
import '../screen/not_found_screen.dart' as _i4;
import '../screen/profile_detail_screen.dart' as _i3;

class Routes extends _i5.RootStackRouter {
  Routes([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeScreen.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    FamilyDetailScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<FamilyDetailScreenArgs>(
          orElse: () => FamilyDetailScreenArgs(
              familyId: pathParams.optString('familyId')));
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i2.FamilyDetailScreen(key: args.key, familyId: args.familyId));
    },
    ProfileDetailScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileDetailScreenArgs>(
          orElse: () => ProfileDetailScreenArgs(
              familyId: pathParams.optString('familyId')));
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i3.ProfileDetailScreen(key: args.key, familyId: args.familyId));
    },
    NotFoundScreen.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.NotFoundScreen());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(HomeScreen.name, path: '/'),
        _i5.RouteConfig(FamilyDetailScreen.name,
            path: '/family-detail/:familyId'),
        _i5.RouteConfig(ProfileDetailScreen.name, path: '/profile/:familyId'),
        _i5.RouteConfig(NotFoundScreen.name, path: '*')
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreen extends _i5.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: '/');

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i2.FamilyDetailScreen]
class FamilyDetailScreen extends _i5.PageRouteInfo<FamilyDetailScreenArgs> {
  FamilyDetailScreen({_i6.Key? key, String? familyId})
      : super(FamilyDetailScreen.name,
            path: '/family-detail/:familyId',
            args: FamilyDetailScreenArgs(key: key, familyId: familyId),
            rawPathParams: {'familyId': familyId});

  static const String name = 'FamilyDetailScreen';
}

class FamilyDetailScreenArgs {
  const FamilyDetailScreenArgs({this.key, this.familyId});

  final _i6.Key? key;

  final String? familyId;

  @override
  String toString() {
    return 'FamilyDetailScreenArgs{key: $key, familyId: $familyId}';
  }
}

/// generated route for
/// [_i3.ProfileDetailScreen]
class ProfileDetailScreen extends _i5.PageRouteInfo<ProfileDetailScreenArgs> {
  ProfileDetailScreen({_i6.Key? key, String? familyId})
      : super(ProfileDetailScreen.name,
            path: '/profile/:familyId',
            args: ProfileDetailScreenArgs(key: key, familyId: familyId),
            rawPathParams: {'familyId': familyId});

  static const String name = 'ProfileDetailScreen';
}

class ProfileDetailScreenArgs {
  const ProfileDetailScreenArgs({this.key, this.familyId});

  final _i6.Key? key;

  final String? familyId;

  @override
  String toString() {
    return 'ProfileDetailScreenArgs{key: $key, familyId: $familyId}';
  }
}

/// generated route for
/// [_i4.NotFoundScreen]
class NotFoundScreen extends _i5.PageRouteInfo<void> {
  const NotFoundScreen() : super(NotFoundScreen.name, path: '*');

  static const String name = 'NotFoundScreen';
}
