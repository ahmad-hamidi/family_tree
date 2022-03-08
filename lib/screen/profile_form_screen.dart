import 'package:family_tree/config/database.dart';
import 'package:family_tree/helpers/component_helper.dart';
import 'package:family_tree/helpers/upload_image_helper.dart';
import 'package:family_tree/screen/bottom_sheet_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileFormScreen extends StatefulWidget {

  final String familyId;
  final bool? isEdit;
  final int? formCode;

  const ProfileFormScreen({Key? key, required this.familyId, this.isEdit, this.formCode}) : super(key: key);

  @override
  _ProfileFormScreenState createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController placeBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController lastEducationController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController statusLifeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? birthDate;
  String? avatar;
  final _formKey = GlobalKey<FormState>();

  int _getFamilyId() {
    return int.tryParse(widget.familyId) ?? 0;
  }

  @override
  void initState() {
    super.initState();
    if (_isEdit()) {
      FirebaseFirestore.instance.collection(Database.familyTable).where("id", isEqualTo: _getFamilyId()).get().then((value) {
        Map<String, dynamic> item = value.docs.first.data();
          nameController.text = item["name"];
          placeBirthController.text = item["place_birth"];
          phoneNumberController.text = item["phone_number"];
          lastEducationController.text = item["last_education"];
          bloodGroupController.text = item["blood_group"];
          genderController.text = item["gender"];
          statusLifeController.text = item["status_life"];
          dateController.text = item["date_birth"];
          avatar = item["avatar"];
          _refresh();
      });
    }
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_isEdit() ? "Change Data" : "Add Member"),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            onBackPage(context);
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              openGallery();
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [_buildList()],
        ),
      ),
    );
  }

  bool _isEdit() {
    return widget.isEdit == true;
  }

  Widget _buildList() {
    final List<Widget> textWidgets = [];

    final nameWidget = Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 24),
      child: buildTextFormField(nameController, "Joni Adam",
          "Full Name", "Full name cannot empty!"),
    );

    final placeBirthWidget = Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 24),
      child: buildTextFormField(placeBirthController, "New York",
          "Place of birth", "Place of birth cannot empty!"),
    );

    final phoneNumberWidget = Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 24),
      child: buildTextFormField(phoneNumberController, "+241994411",
          "Phone Number", "Phone number cannot empty!"),
    );

    final lastEducationWidget = Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 24),
      child: buildTextFormField(lastEducationController, "Bachelor of Economics",
          "Last Education", "Last Education cannot empty!"),
    );

    final buildBloodWidget = Padding(padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: buildDropDownWidget(<String>['A', 'B', 'AB', 'O'], (value) {
      bloodGroupController.text = value ?? "-";
    }, bloodGroupController, "AB",
        "Blood Group", "Blood Group cannot empty!"));

    final buildGenderWidget = Padding(padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
    child: buildDropDownWidget(<String>['Male', 'Female'], (value) {
      genderController.text = value ?? "-";
    }, genderController, "Male",
        "Gender", "Gender cannot empty!"));

    final buildStatusWidget = Padding(padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16), child: buildDropDownWidget(<String>['Life', 'Dead'], (value) {
      statusLifeController.text = value ?? "-";
    }, statusLifeController, "Life",
        "Life Status", "Life Status cannot empty!"));

    final buildDateWidget = Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 24),
      child: buildClickFieldWidget(dateController, "Saturday, 19 December 1988", "Birth of date", "Birth of date cannot empty!", () {
        _openDatePickerWidget();
      }),
    );

    textWidgets.add(InkWell(child: _buildAvatar(), onTap: () {
      openGallery();
    }));

    textWidgets.add(nameWidget);
    textWidgets.add(buildDateWidget);
    textWidgets.add(placeBirthWidget);
    textWidgets.add(phoneNumberWidget);
    textWidgets.add(lastEducationWidget);
    textWidgets.add(buildBloodWidget);
    textWidgets.add(buildGenderWidget);
    textWidgets.add(buildStatusWidget);
    textWidgets.add(
      Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blueAccent, minimumSize: const Size.fromHeight(48)),
            child: const Text("Save", style: const TextStyle(fontSize: 20)),
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                onProcess();
              }
            }),
      ),
    );

    return Expanded(
      child: ListView(
        children: textWidgets,
      ),
    );
  }

  void openGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    showLoadingDialog(context);
    final stream = uploadFile(context, image).asStream();
    final state = await stream.last;

    while (state?.snapshot.state == firebase_storage.TaskState.running) {
      await Future.delayed(const Duration(seconds: 3));
    }

    if (state?.snapshot.state == firebase_storage.TaskState.success) {
      state?.snapshot.ref.getDownloadURL().then((downloadUrl) {
        avatar = downloadUrl;
        Navigator.pop(context);
        _refresh();
      });
    }
  }

  Map<String, dynamic> _getParams() {
    Map<String, dynamic> params = {
      "name": nameController.text,
      "gender": genderController.text,
      "date_birth": dateController.text,
      "place_birth": placeBirthController.text,
      "phone_number": phoneNumberController.text,
      "last_education": lastEducationController.text,
      "status_life": statusLifeController.text,
      "blood_group": bloodGroupController.text,
      "avatar": avatar,
    };

    if (_isEdit() == false) {
      params["id"] = DateTime.now().millisecondsSinceEpoch;
      if (widget.formCode == BottomSheetScreen.spouseCode) {
        params["parent_id"] = _getFamilyId();
        params["child_id"] = null;
      } else if (widget.formCode == BottomSheetScreen.childCode) {
        params["parent_id"] = _getFamilyId();
        params["child_id"] = _getFamilyId();
      }
    }
    return params;
  }

  void onProcess() async {
    showLoadingDialog(context);

    if (_isEdit()) {
      final query = await FirebaseFirestore.instance.collection(Database.familyTable).where("id", isEqualTo: _getFamilyId()).get();
      query.docs.first.reference.update(_getParams());
      _hideLoadingDialog();
      Navigator.pop(context);
    } else {
      final result = await FirebaseFirestore.instance.collection(Database.familyTable).add(_getParams());
      if (result.id.isNotEmpty == true) {
        _hideLoadingDialog();
        Navigator.pop(context);
      } else {
        _hideLoadingDialog();
        showSnackBar(context, "Failed create");
      }
    }
  }

  void _hideLoadingDialog() {
    Navigator.pop(context);
  }

  void _openDatePickerWidget() {
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        ),
        elevation: 20,
        isScrollControlled: true,
        builder: (ctx) {
          return FractionallySizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(height: 5, width: 80, margin: const EdgeInsets.only(top: 16, bottom: 16), decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
                  SizedBox(
                    height: 150,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime(1969, 1, 1),
                      onDateTimeChanged: (DateTime newDateTime) {
                        birthDate = newDateTime;
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blueAccent, minimumSize: const Size.fromHeight(48)),
                      child: const Text("Choose Date", style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        dateController.text = dateFormatID("EEEE, dd MMMM yyyy").format(birthDate ?? DateTime.now());
                        _refresh();
                        Navigator.pop(context);
                      }),
                ],
              ),
            )
          );
        }).then((value) {});
  }

  Widget _buildAvatar() {
    if (avatar != null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.network(avatar ?? "", width: getImageWidthScreen(context), height: getImageHeightScreen(context))
        ],
      );
    } else {
      return Image.network("https://firebasestorage.googleapis.com/v0/b/udemyaffiliate-bbdf6.appspot.com/o/foto%2Fplaceholder.png?alt=media&token=2dd80eef-a4a2-4183-9f5f-80a25a243c34", width: getImageWidthScreen(context), height: getImageHeightScreen(context));
    }
  }
}