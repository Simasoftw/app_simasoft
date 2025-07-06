import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:flutter/material.dart';

class CardRequest extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback callback;
  final String? typeLoan;

  CardRequest({
    super.key,
    required this.icon,
    required this.text,
    required this.callback,
    this.typeLoan,
  });

  @override
  State<CardRequest> createState() => _CardRequestState();
}

class _CardRequestState extends State<CardRequest> {
  @override
  Widget build(BuildContext context) {
    bool isBirthdayBonus = widget.typeLoan == "Bono de cumpleaños";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Card superior (azul)
        GestureDetector(
          onTap: widget.callback,
          child: Container(
            padding: EdgeInsets.all(Dimensions.space16),
            decoration: BoxDecoration(
              borderRadius:
                  isBirthdayBonus
                      ? const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      )
                      : BorderRadius.circular(Dimensions.cardMediumRadius),
              color: MyColor.secondaryColor,
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: Dimensions.space25,
                  color: MyColor.iconsColor,
                ),
                SizedBox(width: Dimensions.space10),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: Dimensions.space20,
                    color: MyColor.colorWhite,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Card inferior (verde), solo si es Bono de cumpleaños
        if (isBirthdayBonus)
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFCFE9D8),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "¡Tienes un bono de 40.000!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: widget.callback,
                    child: const Text(
                      "Solicitar bono",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
