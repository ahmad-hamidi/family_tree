import 'package:family_tree/config/database.dart';
import 'package:family_tree/helpers/bottom_sheet_helper.dart';
import 'package:family_tree/models/family_model.dart';
import 'package:family_tree/widgets/family_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //generateFirestoreData(),
        const SizedBox(height: 16),
        _buildParentWidget(),
        Container(),
        _buildChildWidget(),
      ],
    );
  }

  Widget _buildParentWidget() {
    return StreamBuilder<QuerySnapshot?>(
      stream: FirebaseFirestore.instance
          .collection(Database.familyTable)
          .where("id", isLessThan: 0)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
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

            widgets.add(
              FamilyItemWidget(
                avatarUrl: model.avatar,
                name: model.name,
                onClickListener: () {
                  BottomSheetHelper(context: context, isSeeFamily: false)
                      .openBottomSheet(model, (code) {});
                },
                isRoot: true,
              ),
            );

            widgets.add(const SizedBox(height: 16));
          }

          widgets.add(Container(
            color: Colors.blue,
            width: 1,
            height: 50,
          ));

          return Column(
              mainAxisAlignment: MainAxisAlignment.center, children: widgets);
        }
      },
    );
  }

  Widget _buildChildWidget() {
    return StreamBuilder<QuerySnapshot?>(
      stream: FirebaseFirestore.instance
          .collection(Database.familyTable)
          .where("id", isGreaterThan: 0)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return const SizedBox();
        } else {
          final List<Widget> widgets = [];

          final store = snapshot.data?.docs ?? [];
          for (final items in store) {
            Map<String, dynamic> item = items.data() as Map<String, dynamic>;
            final FamilyModel model = FamilyModel.mapping(item);

            if (model.parentId == null && model.childId == null) {
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

  Widget generateFirestoreData() {
    return InkWell(
      child: const Text("Generate"),
      onTap: () {
        for (var element in Database.families) {
          FirebaseFirestore.instance
              .collection(Database.familyTable)
              .add(element);
        }
      },
    );
  }
}
