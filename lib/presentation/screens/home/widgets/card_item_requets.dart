import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardRequest extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback callback;
  final String? typeLoan;
  final String? birthdayBonus;
  final String? birthDate;

  CardRequest({
    super.key,
    required this.icon,
    required this.text,
    required this.callback,
    this.typeLoan,
    this.birthdayBonus,
    this.birthDate,
  });

  @override
  State<CardRequest> createState() => _CardRequestState();
}

class _CardRequestState extends State<CardRequest> {
  String? estadoCumpleano = "Enviada";
  bool esCumpleanios(DateTime fechaNacimiento) {
    final hoy = DateTime.now(); // hora local (America/Bogotá en tu dispositivo)
    return hoy.month == fechaNacimiento.month && hoy.day == fechaNacimiento.day;
  }

  Future<String?> obtenerTemporal(String clave) async {
    final prefs = await SharedPreferences.getInstance();

    final int? expiryMillis = prefs.getInt('${clave}_expiry');
    if (expiryMillis == null) return null;

    final ahora = DateTime.now().millisecondsSinceEpoch;
    if (ahora > expiryMillis) {
      // Se venció → borrar
      prefs.remove(clave);
      prefs.remove('${clave}_expiry');
      await prefs.remove("SolicitudCumpleanos");
      return null;
    }

    return prefs.getString(clave);
  }

  Future<void> validarSolicitud() async {
    estadoCumpleano = await obtenerTemporal("SolicitudCumpleanos");
  }

  @override
  void initState() {
    super.initState();
    validarSolicitud();
  }

  @override
  Widget build(BuildContext context) {
    bool isBirthdayBonus = widget.typeLoan == "Bono de cumpleaños";
    final formatter = NumberFormat("#,##0", "en_US");

    final DateTime nacimiento = DateFormat(
      'yyyy-MM-dd',
    ).parse(widget.birthDate ?? '9999-01-01'); // convierte a DateTime

    final bool esHoy = esCumpleanios(nacimiento);

    String bonus = "";
    final int? parsed = int.tryParse(widget.birthdayBonus ?? '');
    if (parsed != null) {
      bonus = formatter.format(parsed);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Card superior (azul)
        GestureDetector(
          onTap: isBirthdayBonus ? null : widget.callback,
          child: Container(
            padding: EdgeInsets.all(Dimensions.space16),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    isBirthdayBonus && esHoy && estadoCumpleano != "Enviada"
                        ? Color(0xFFCFE9D8)
                        : MyColor.secondaryColor, // el color que quieras
                width: 2, // grosor en píxeles
              ),
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
        if (isBirthdayBonus && esHoy && estadoCumpleano != "Enviada")
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
                Text(
                  "¡Tienes un bono de ${bonus}!",
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
