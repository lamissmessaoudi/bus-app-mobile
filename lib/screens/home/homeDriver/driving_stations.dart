import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/screens/home/homeDriver/home_driver_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
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
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Container(
              // color: Colors.pink,
              width: 50,
              child: GestureDetector(
                child: Image.asset(
                  Assets.backFloating,
                  width: 50,
                ),
                onTap: controller.returnPage,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                // color: Colors.amber,
                margin: EdgeInsets.only(bottom: 15),
                child: Center(
                  child: Text(
                    " ${controller.chosenCircuit?.name}",
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.primarySlab36,
                  ),
                ),
              ),
            ),
            Container(
                // color: Colors.pink,
                width: 50,
                child: GestureDetector(
                  child: Image.asset(
                    Assets.nextFloating,
                    width: 50,
                  ),
                  onTap: () {
                    controller.step?.value = DrivingStep.startDriving;
                    controller.update();
                  },
                )),
          ],
        ),
        SizedBox(height: 20),
        getStationCards(controller.chosenCircuit?.station),
      ],
    );
  }
}

getStationCards(List<StationDto>? list) {
  return Column(children: [
    SizedBox(),
    ...?list?.map((item) => StationCard(station: item))
  ]);
}
