import 'package:auto_route/auto_route.dart';
import 'package:family_tree/config/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TextFormField buildTextFormField(TextEditingController controller,
    String hintText, String labelText, String validatorMessage) {
  return TextFormField(
    validator: (value) {
      return value?.trim().isEmpty == true ? validatorMessage : null;
    },
    controller: controller,
    style: TextStyle(fontSize: 18),
    decoration: InputDecoration(
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: hintText,
        labelText: labelText),
  );
}

showLoadingDialog(BuildContext context, {bool isOutsideDismiss = false}) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: Container(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
          SizedBox(height: 8),
          Text(
            "Mohon Tunggu...",
          ),
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: isOutsideDismiss,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

void showChooseDialog(BuildContext context, String message, String trueText, String falseText, Function callback(bool), {bool isOutsideDismiss = false}) {
  Widget trueButton = InkWell(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(trueText),
    ),
    onTap: () {
      Navigator.of(context).pop();
      if (callback != null) {
        callback(true);
      }
    },
  );
  Widget falseButton = InkWell(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(falseText),
    ),
    onTap: () {
      Navigator.of(context).pop();
      if (callback != null) {
        callback(false);
      }
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: Text(message),
    actions: [
      trueButton,
      falseButton
    ],
  );

  showDialog(
    context: context,
    barrierDismissible: isOutsideDismiss,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

DateFormat dateFormatID(String format) {
  return DateFormat(format);
}

Widget buildDropDownWidget(List<String> data, Function(String?) callback, TextEditingController controller,
    String hintText, String labelText, String validatorMessage) {
  return DropdownButton<String>(
    underline: Container(height: 0),
    isExpanded: true,
    hint: TextFormField(
      validator: (value) {
        return value?.trim().isEmpty == true ? validatorMessage : null;
      },
      controller: controller,
      decoration: InputDecoration(
          fillColor: Colors.white,
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hintText,
          labelText: labelText),
    ),
    items: data.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value, style: const TextStyle(color: Colors.black)),
      );
    }).toList(),
    iconEnabledColor: Colors.white,
    onChanged: (value) {
      callback(value);
    },
  );
}

Widget buildClickFieldWidget(TextEditingController controller,
    String hintText, String labelText, String validatorMessage, Function() callback) {
  return InkWell(
    onTap: () {
      callback();
    },
    child: TextFormField(
      enabled: false,
      validator: (value) {
        return value?.trim().isEmpty == true ? validatorMessage : null;
      },
      controller: controller,
      decoration: InputDecoration(
          fillColor: Colors.white,
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hintText,
          labelText: labelText),
    ),
  );
}

void onBackPage(BuildContext context) {
  if (AutoRouter.of(context).stack.length == 1) {
    AutoRouter.of(context).replaceAll([const HomeScreen()]);
  } else {
    Navigator.pop(context);
  }
}

double getImageWidthScreen(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getImageHeightScreen(BuildContext context) {
  return MediaQuery.of(context).size.height / 3;
}