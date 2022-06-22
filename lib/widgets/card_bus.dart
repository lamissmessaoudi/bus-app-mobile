import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_dialog.dart';

class BusCard extends StatelessWidget {
  final String bus, arrivee, stationActuelle;
  final CircuitDto? circuit;
  BusCard({
    Key? key,
    required this.bus,
    required this.circuit,
    required this.arrivee,
    required this.stationActuelle,
  }) : super(key: key);

  final controller = Get.put(HomeColabController());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  Assets.bus,
                  width: 60,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    circuit!.available
                        ? Text(bus, style: AppTextStyles.primarySlab24)
                        : SizedBox(height: 0),
                    Text(
                      circuit!.name,
                      style: AppTextStyles.primarySlab17,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: circuit!.available
                        ? AppColors.errorColor
                        : AppColors.green),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                    child: Text(
                      circuit!.available ? "Indisponible" : "Disponible",
                      style: AppTextStyles.primarySlab17
                          .copyWith(color: AppColors.white),
                    )),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            circuit!.available
                ? Text(
                    "Aucun bus n'est encore assigné à circuit",
                    style: AppTextStyles.primarySlab17,
                  )
                : Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          isSmall: true,
                          width: null,
                          text: "Réserver",
                          btnType: BtnType.AccentOutlined,
                          onTap: () =>
                              reserverDialog(context, controller, circuit!),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Future<dynamic> reserverDialog(
    BuildContext context,
    HomeColabController controller,
    CircuitDto circuit,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Réserver à partir de',
                  style: AppTextStyles.primarySlab24,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Image.asset(
                          Assets.locationMap,
                          height: 60,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    CustomButton(
                      text: "Votre station actuelle ",
                      isSmall: true,
                      btnType: BtnType.AccentFilled,
                      onTap: () => controller.reserverBus(
                        circuit: circuit,
                        longitude: controller.chosenStation!.longitude,
                        latitude: controller.chosenStation!.latitude,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 230,
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          splashColor: AppColors.accentColor,
                          onTap: () async {
                            await controller.reserverBus(
                              circuit: circuit,
                              longitude: controller.chosenStation!.longitude,
                              latitude: controller.chosenStation!.latitude,
                            );
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.accentColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Text(
                                "Votre station actuelle ",
                                style: AppTextStyles.primarySlab17
                                    .copyWith(color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "Autre position dans map",
                      isSmall: true,
                      btnType: BtnType.AccentOutlined,
                      onTap: () async {
                        var p = await showSimplePickerLocation(
                          context: context,
                          isDismissible: true,
                          title: "Selectionner l'addresse",
                          textConfirmPicker: "Envoyer",
                          initCurrentUserPosition: true,
                          initZoom: 15,
                        ).then((p) async {
                          if (p != null) {
                            await controller.reserverBus(
                              circuit: circuit,
                              longitude: p.longitude,
                              latitude: p.latitude,
                            );
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
