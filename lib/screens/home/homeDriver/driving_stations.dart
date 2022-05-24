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
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    " ${controller.chosenCircuit?.name}",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.primarySlab36,
                  ),
                ),
              ),
            ),
            Container(
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
    // Row(
    //   children: [
    //     Container(
    //       color: AppColors.green,
    //       width: 50,
    //       child: GestureDetector(
    //         child: Image.asset(
    //           Assets.backFloating,
    //           width: 50,
    //         ),
    //         onTap: controller.returnPage,
    //       ),
    //     ),
    //     Expanded(
    //       child: Container(
    //         color: AppColors.blue,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Container(
    //               margin: EdgeInsets.symmetric(horizontal: 20),
    //               child: Text(
    //                 " ${controller.chosenCircuit?.name}",
    //                 textAlign: TextAlign.center,
    //                 style: AppTextStyles.primarySlab36,
    //               ),
    //             ),
    //             SizedBox(height: 20),
    //             getStationCards(controller.chosenCircuit?.station),
    //           ],
    //         ),
    //       ),
    //     ),
    //     // Obx(() {return
    //     Container(
    //         width: 50,
    //         color: AppColors.green,
    //         child: GestureDetector(
    //           child: Image.asset(
    //             Assets.nextFloating,
    //             width: 50,
    //           ),
    //           onTap: () {
    //             controller.step?.value = DrivingStep.startDriving;
    //             controller.update();
    //           },
    //         ))
    //     //       ;
    //     // })
    //     ,
    //   ],
    // );
  }
}

getStationCards(List<Station>? list) {
  return Column(children: [
    SizedBox(),
    ...?list?.map((item) => StationCard(station: item))
  ]);
}
