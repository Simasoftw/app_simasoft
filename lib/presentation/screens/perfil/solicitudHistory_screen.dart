import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/data/controllers/requets/requests_controller.dart';
import 'package:app_simasoft/data/model/requets/requets.dart';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class Solicitud {
  final String tipo;
  final DateTime fecha;
  final String estado;

  Solicitud({required this.tipo, required this.fecha, required this.estado});
}

class SolicitudHistoryScreen extends StatefulWidget {
  List<Requets>? dataRequets;

  SolicitudHistoryScreen({Key? key, this.dataRequets}) : super(key: key);

  @override
  State<SolicitudHistoryScreen> createState() => _SolicitudHistoryScreenState();
}

class _SolicitudHistoryScreenState extends State<SolicitudHistoryScreen> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final formatterNumber = NumberFormat("#,##0", "en_US");
  List<Solicitud> solicitudes = [];

  @override
  void initState() {
    super.initState();
  }

  Color _colorPorEstado(String estado) {
    switch (estado) {
      case 'ACTIVE':
        return Colors.green;
      case 'REJECTED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      case 'FINIS':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _textPorEstado(String estado) {
    switch (estado) {
      case 'REJECTED':
        return "Rechazado";
      case 'ACTIVE':
        return "Aprobado";
      case 'PENDING':
        return "En Proceso";
      case 'FINIS':
        return "Verificado";
      default:
        return "Sin Definir";
    }
  }

  String _textPorTipo(String estado) {
    switch (estado) {
      case 'PAYROLL_ADVANCE':
        return "Adelanto de nómina";
      case 'REFUELING':
        return "Retanqueo";
      case 'BIRTHDAY_BONUS':
        return "Bono de Cumpleaño";
      case 'PROVIDE_LOAN':
        return "Préstamo preaprobado";
      default:
        return "Sin Definir";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Histórico de Solicitudes",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.space20,
            color: MyColor.colorWhite,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Aquí defines el color del ícono de "volver"
        ),
        backgroundColor: MyColor.homeColor,
      ),
      body: Container(
        color: MyColor.homeColor,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.space1),
        child:
            widget.dataRequets!.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                  itemCount: widget.dataRequets?.length ?? 0,
                  itemBuilder: (context, index) {
                    final solicitud = widget.dataRequets![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.description,
                              color: Colors.teal,
                            ),
                            title: Text(
                              _textPorTipo(solicitud.type ?? ""),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: Dimensions.space15,
                                color: MyColor.homeColor,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Valor \$ ${formatterNumber.format(solicitud.amount)}",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.space12,
                                    color: MyColor.homeColor,
                                  ),
                                ),
                                Text(
                                  "Fecha: ${formatter.format(DateTime.parse(solicitud.createdAt ?? ""))}",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.space12,
                                    color: MyColor.homeColor,
                                  ),
                                ),
                              ],
                            ),

                            trailing:
                                (solicitud.type != "PROVIDE_LOAN" || (solicitud.type == "PROVIDE_LOAN" && solicitud.status != "PENDING"))
                                    ? Chip(
                                      label: Text(
                                        _textPorEstado(
                                          solicitud.status ?? "N.A",
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimensions.space12,
                                          color: MyColor.colorWhite,
                                        ),
                                      ),
                                      backgroundColor: _colorPorEstado(
                                        solicitud.status ?? "N.A",
                                      ),
                                    )
                                    : SizedBox.shrink(),
                          ),
                          (solicitud.type == "PROVIDE_LOAN" && solicitud.status == "PENDING")
                              ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: GetBuilder<RequestController>(
                                  builder:
                                      (controller) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                    Color
                                                  >(Colors.red),
                                            ),
                                            label: const Text(
                                              'Rechazar',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              String status = 'REJECTED';
                                              int id = solicitud.id;
                                              controller.updateRequestLoan(
                                                status,
                                                id,
                                                context
                                              ); 
                                            },
                                          ),

                                          const SizedBox(width: 8),
                                          TextButton.icon(
                                            icon: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                    Color
                                                  >(Colors.green),
                                            ),
                                            label: const Text(
                                              'Aceptar',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: ()  {
                                              String status = 'ACTIVE';
                                              int id = solicitud.id;
                                              controller.updateRequestLoan(
                                                status,
                                                id,
                                                context
                                              ); 
                                            }, 
                                          ),
                                        ],
                                      ),
                                ),
                              )
                              : const SizedBox(),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
