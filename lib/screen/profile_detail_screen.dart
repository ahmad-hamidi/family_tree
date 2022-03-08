import 'package:family_tree/config/database.dart';
import 'package:family_tree/helpers/component_helper.dart';
import 'package:family_tree/models/family_model.dart';
import 'package:family_tree/screen/profile_form_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({Key? key, @PathParam('familyId') this.familyId})
      : super(key: key);

  final String? familyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            onBackPage(context);
          },
        ),
      ),
      body: _buildProfileWidget(context),
    );
  }

  Widget _buildTitleSubtitle(String title, String? subtitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle ?? "-",
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileWidget(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(Database.familyTable)
          .where("id", isEqualTo: int.tryParse(familyId ?? "0") ?? 0)
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
          Map<String, dynamic> item =
              snapshot.data?.docs.first.data() as Map<String, dynamic>;
          final FamilyModel? model = FamilyModel.mapping(item);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(model?.avatar, context),
                _buildTitleSubtitle("Name", model?.name),
                _buildTitleSubtitle("Date of Birth", model?.dateBirth),
                _buildTitleSubtitle("Place of Birth", model?.placeBirth),
                _buildTitleSubtitle("Gender", model?.gender),
                _buildTitleSubtitle("Phone Number", model?.phoneNumber),
                _buildTitleSubtitle(
                    "Last Education", model?.lastEducation),
                _buildTitleSubtitle("Life Status", model?.statusLife),
                _buildTitleSubtitle("Blood Group", model?.bloodGroup),
                const SizedBox(height: 10),
                _buildEditButton(context)
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildAvatar(String? avatar, BuildContext context) {
    if (avatar != null) {
      return Center(child: Image.network(avatar, width: getImageWidthScreen(context), height: getImageHeightScreen(context)));
    } else {
      return Image.network("https://firebasestorage.googleapis.com/v0/b/udemyaffiliate-bbdf6.appspot.com/o/foto%2Fplaceholder.png?alt=media&token=2dd80eef-a4a2-4183-9f5f-80a25a243c34", width: getImageWidthScreen(context), height: getImageHeightScreen(context));
    }
  }

  Widget _buildEditButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent, minimumSize: const Size.fromHeight(48)),
          child: const Text("Change Data", style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileFormScreen(familyId: familyId ?? "", isEdit: true),
              ),
            );
          }),
    );
  }
}
