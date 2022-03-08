import 'package:family_tree/config/routes.gr.dart';
import 'package:family_tree/models/family_model.dart';
import 'package:family_tree/screen/bottom_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class BottomSheetHelper {
  BuildContext context;
  bool? isAddChild, isAddSpouse, isSeeFamily;

  BottomSheetHelper({required this.context, this.isAddChild, this.isAddSpouse, this.isSeeFamily = true});

  void openBottomSheet(FamilyModel model, Function(int) callback) {
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        ),
        elevation: 10,
        isScrollControlled: true,
        builder: (ctx) {
          return FractionallySizedBox(
            heightFactor: 0.4,
            child: BottomSheetScreen(
                name: model.name,
                isAddChild: isAddChild,
                isAddSpouse: isAddSpouse,
                isSeeFamily: isSeeFamily,
                callback: (code) {
                  _onProcessBottomSheet(code, model);
                  callback(code);
                }),
          );
        }).then((value) {});
  }

  void _onProcessBottomSheet(int code, FamilyModel model) {
    Navigator.pop(context);
    if (code == BottomSheetScreen.profileCode) {
      openProfileDetail("${model.id}");
    } else if (code == BottomSheetScreen.familyCode) {
      openFamilyDetail("${model.id}");
    }
  }

  void openProfileDetail(String familyId) {
    context.pushRoute(ProfileDetailScreen(familyId: familyId));
  }

  void openFamilyDetail(String familyId) {
    context.pushRoute(FamilyDetailScreen(familyId: familyId));
  }
}
