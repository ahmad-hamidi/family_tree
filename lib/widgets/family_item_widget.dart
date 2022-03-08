import 'package:flutter/material.dart';

class FamilyItemWidget extends StatelessWidget {
  final String? avatarUrl, name;
  final bool? isRoot;
  final double? height;
  final Function onClickListener;

  const FamilyItemWidget(
      {Key? key,
      required this.avatarUrl,
      required this.name,
      required this.onClickListener,
      this.isRoot,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                name ?? "-",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        onClickListener();
      },
    );
  }
}
