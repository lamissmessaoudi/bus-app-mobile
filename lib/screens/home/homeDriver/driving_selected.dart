import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/card_circuit.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';

class DrivingSelected extends StatefulWidget {
  const DrivingSelected({
    Key? key,
  }) : super(key: key);

  @override
  _DrivingSelectedState createState() => _DrivingSelectedState();
}

class _DrivingSelectedState extends State<DrivingSelected> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeDriverController());

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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Votre circuit pour ajourd’hui :",
              style: AppTextStyles.primarySlab20,
            ),
          ),
          SizedBox(height: 20),
          CircuitCard(circuit: controller.chosenCircuit),
          SizedBox(height: 20),
          CustomButton(
            text: "Visualiser",
            onTap: () => Get.toNamed(Routes.visualize),
            isSmall: true,
            btnType: BtnType.AccentFilled,
          ),
          SizedBox(height: 20),
          Wrap(
            children: [
              ...controller.chosenCircuit!.station.map(
                (e) => Container(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.saumonColor),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Text(
                      e.name,
                      style: AppTextStyles.primarySlab17,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
