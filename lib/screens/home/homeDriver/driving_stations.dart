import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/card_station.dart';

class DrivingStations extends StatefulWidget {
  const DrivingStations({
    Key? key,
  }) : super(key: key);

  @override
  _DrivingStationsState createState() => _DrivingStationsState();
}

class _DrivingStationsState extends State<DrivingStations> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeDriverController());

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              " ${controller.chosenCircuit?.name}",
              textAlign: TextAlign.center,
              style: AppTextStyles.primarySlab36,
            ),
          ),
          SizedBox(height: 20),
          getStationCards(controller.chosenCircuit?.station),
        ],
      ),
    );
  }
}

getStationCards(List<Station>? list) {
  return Column(children: [
    SizedBox(),
    ...?list?.map((item) => StationCard(station: item))
  ]);
}
