import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:flutter/material.dart';




class CardRequest extends StatefulWidget {
  IconData icon;
  String text;
  final VoidCallback callback;

  CardRequest({super.key, required this.icon, required this.text, required this.callback});

  @override
  State<CardRequest> createState() => _CardRequestState();
}

class _CardRequestState extends State<CardRequest> {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  widget.callback,
      child: Container(
        padding: EdgeInsets.all(Dimensions.space16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.cardMediumRadius),
          color: MyColor.secondaryColor
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: Dimensions.space25,
              color: MyColor.iconsColor,
            ),
            SizedBox(width: Dimensions.space10),
            Text(widget.text,
              style: boldOverWhiteLarge,
            ),
          ],
        ),
      ),
    );
  }
}
