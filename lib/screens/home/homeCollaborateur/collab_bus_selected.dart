import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';

class CollabBusSelected extends StatelessWidget {
  CollabBusSelected({Key? key}) : super(key: key);
  final controller = Get.put(HomeColabController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Bonjour ${controller.name}",
              textAlign: TextAlign.center,
              style: AppTextStyles.primarySlab36,
            ),
          ),
          SizedBox(height: 40),

          // Station Card
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        Assets.locationColored,
                        width: 60,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(controller.fetchedUser.station.name,
                              style: AppTextStyles.primarySlab24),
                          Text(
                            controller.fetchedUser.station.description,
                            style: AppTextStyles.primarySlab17,
                          )
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Votre Bus:",
              style: AppTextStyles.primarySlab24,
            ),
          ),
          SizedBox(height: 10),

          BusCardSelected(
            bus: "bus",
            circuit: controller.chosenCircuit,
            chauffeurName: controller.chosenTrajet?.user.name,
            chauffeurTel: controller.chosenTrajet?.user.phone,
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Visualiser",
            onTap: () => Get.toNamed(Routes.visualize),
            // isSmall: true,
            width: null,
            btnType: BtnType.AccentFilled,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class BusCardSelected extends StatelessWidget {
  final String bus;
  final CircuitDto? circuit;
  final String? chauffeurName;
  final String? chauffeurTel;
  BusCardSelected({
    Key? key,
    required this.bus,
    required this.circuit,
    required this.chauffeurName,
    required this.chauffeurTel,
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
                    Text(bus, style: AppTextStyles.primarySlab24),
                    Text(
                      circuit!.name,
                      style: AppTextStyles.primarySlab17,
                    )
                  ],
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Text(
              "Chauffeur :  $chauffeurName",
              style: AppTextStyles.primarySlab17,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Contact : $chauffeurTel",
                style: AppTextStyles.primarySlab17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
