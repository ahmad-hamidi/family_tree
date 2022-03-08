import 'package:family_tree/config/database.dart';
import 'package:family_tree/helpers/bottom_sheet_helper.dart';
import 'package:family_tree/helpers/component_helper.dart';
import 'package:family_tree/models/family_model.dart';
import 'package:family_tree/screen/profile_form_screen.dart';
import 'package:family_tree/widgets/family_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyDetailScreen extends StatelessWidget {
  const FamilyDetailScreen({Key? key, @PathParam('familyId') this.familyId})
      : super(key: key);

  final String? familyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Family Detail"),
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              onBackPage(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildChart(),
            ],
          ),
        ),);
  }

  int _getFamilyId() {
    return int.tryParse(familyId ?? "0") ?? 0;
  }

  Widget _buildChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        _buildParentWidget(),
        Container(
          margin: const EdgeInsets.only(top: 16),
          color: Colors.blue,
          width: 1,
          height: 30,
        ),
        Container(),
        _buildChildWidget(),
      ],
    );
  }

  Widget _buildParentWidget()  {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Database.familyTable)
            .where("id", isGreaterThan: 0)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {

            final List<Widget> widgets = [];

            final store = snapshot.data?.docs ?? [];

            for (final items in store) {
              Map<String, dynamic> item = items.data() as Map<String, dynamic>;
              final FamilyModel model = FamilyModel.mapping(item);

              if (widgets.length <= 2 && (model.id == _getFamilyId() || model.parentId == _getFamilyId())) {
                widgets.add(const SizedBox(height: 16));
                widgets.add(
                  FamilyItemWidget(
                    avatarUrl: model.avatar,
                    name: model.name,
                    onClickListener: () {
                      BottomSheetHelper(
                          context: context, isAddChild: model.parentId == _getFamilyId(), isAddSpouse: model.id == _getFamilyId(), isSeeFamily: false)
                          .openBottomSheet(model, (code) {
                            _openProfileForm(context, code);
                      });
                    },
                    isRoot: true,
                  ),
                );
              }
            }

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, children: widgets),
            );
          }
        },
      );
  }

  Widget _buildChildWidget() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(Database.familyTable)
          .where("id", isGreaterThan: 0)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final List<Widget> widgets = [];

          final store = snapshot.data?.docs ?? [];
          for (final items in store) {
            Map<String, dynamic> item = items.data() as Map<String, dynamic>;
            final FamilyModel model = FamilyModel.mapping(item);

            if (model.childId != null && model.parentId == _getFamilyId()) {
              widgets.add(const SizedBox(height: 30));
              widgets.add(
                FamilyItemWidget(
                  avatarUrl: model.avatar,
                  name: model.name,
                  onClickListener: () {
                    BottomSheetHelper(context: context)
                        .openBottomSheet(model, (code) {});
                  },
                ),
              );
            }
          }

          widgets.add(const SizedBox(height: 30));
          return SingleChildScrollView(
              child: Column(children: widgets), scrollDirection: Axis.vertical);
        }
      },
    );
  }

  void _openProfileForm(BuildContext context, int code) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileFormScreen(familyId: familyId ?? "", formCode: code),
      ),
    );
  }
}