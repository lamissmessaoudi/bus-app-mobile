import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/card_circuit.dart';

class DrivingCircuits extends StatefulWidget {
  const DrivingCircuits({
    Key? key,
  }) : super(key: key);

  @override
  _DrivingCircuitsState createState() => _DrivingCircuitsState();
}

class _DrivingCircuitsState extends State<DrivingCircuits> {
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
              "Veuillez  choisir votre circuit:",
              style: AppTextStyles.primarySlab20,
            ),
          ),
          SizedBox(height: 20),
          getStationCards(controller.circuitList, controller),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

getStationCards(List<Circuit>? list, HomeDriverController controller) {
  return Column(children: [
    SizedBox(),
    ...?list?.map(
      (item) => GestureDetector(
          child: CircuitCard(circuit: item),
          onTap: () => controller.setCircuit(item)),
    )
  ]);
}
