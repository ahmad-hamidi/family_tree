
import 'package:flutter/material.dart';

class BottomSheetScreen extends StatelessWidget {
  final String? name;
  final Function(int) callback;
  final bool? isAddChild, isAddSpouse, isSeeFamily;

  static int profileCode = 0;
  static int familyCode = 1;
  static int cancelCode = -1;
  static int spouseCode = -2;
  static int childCode = -3;

  const BottomSheetScreen(
      {Key? key, required this.name, required this.callback, this.isAddChild, this.isAddSpouse, this.isSeeFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Text(
                name ?? "",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
            _itemMenuWidget(
                "Profile Detail", Icons.person_pin, profileCode, (code) {
              callback(code);
            }),
            isSeeFamily == true ? _itemMenuWidget("Family Detail",
                Icons.family_restroom_rounded, familyCode, (code) {
                  callback(code);
                }) : const SizedBox(),
            isAddChild == true ? _itemMenuWidget("Add Child",
                Icons.person_add_alt_1_rounded, childCode, (code) {
                  callback(code);
                }) : const SizedBox(),
            isAddSpouse == true ? _itemMenuWidget("Add Spouse",
                Icons.female_rounded, spouseCode, (code) {
                  callback(code);
                }) : const SizedBox(),
            _itemMenuWidget("Cancel", Icons.clear, cancelCode, (code) {
              callback(code);
            }),
          ],
        ),
      ),
    );
  }

  Widget _itemMenuWidget(
      String menuName, IconData icon, int code, Function(int) callback) {
    return TextButton.icon(
      onPressed: () {
        callback(code);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(16),
        ),
        alignment: Alignment.centerLeft,
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 48),
        ),
      ),
      icon: Icon(icon, size: 32),
      label: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(menuName, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
