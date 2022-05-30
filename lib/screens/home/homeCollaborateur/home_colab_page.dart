import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/card_bus.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_dialog.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class HomeColabPage extends StatelessWidget {
  const HomeColabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<HomeColabController>(
            init: HomeColabController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingHome.value
                  ? CustomLoader()
                  : SingleChildScrollView(
                      child: Center(
                        child: Container(
                          width: 500,
                          margin: EdgeInsets.symmetric(horizontal: 35),
                          padding: EdgeInsets.only(top: 20, bottom: 10),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Image.asset(
                                            Assets.locationColored,
                                            width: 60,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  controller
                                                      .fetchedUser.station.name,
                                                  style: AppTextStyles
                                                      .primarySlab24),
                                              Text(
                                                controller.fetchedUser.station
                                                    .description,
                                                style:
                                                    AppTextStyles.primarySlab17,
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomButton(
                                        isSmall: true,
                                        width: null,
                                        text: "Changer la Station",
                                        btnType: BtnType.AccentOutlined,
                                        onTap: () => changeStationDialog(
                                            context, controller),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Bus passants par vous:",
                                  style: AppTextStyles.primarySlab24,
                                ),
                              ),
                              SizedBox(height: 20),

                              //  Bus Card
                              getBusCards(controller.fetchedUser.station.circuit
                                  // .where((e) => !e.available)
                                  // .toList()
                                  )
                            ],
                          ),
                        ),
                      ),
                    );
            }),
      ),
    );
  }

  getBusCards(List<CircuitDto>? list) {
    return Column(children: [
      SizedBox(),
      ...?list?.map((item) => BusCard(
            circuit: item,
            arrivee: " 5 mins",
            bus: "Bus n°34",
            stationActuelle: "Menzah 5",
          ))
    ]);
  }

  Future<dynamic> changeStationDialog(
      BuildContext context, HomeColabController controller) {
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
                  'Changer votre station',
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
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Choisissez votre Station ",
                        style: AppTextStyles.hintPTMono18,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: controller.formKeyStation,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          decoration: InputDecoration(
                            focusColor: AppColors.accentColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.borderColor,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.accentColor,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.errorColor,
                                width: 2.0,
                              ),
                            ),
                            filled: true,
                          ),
                          value: controller.chosenStation,
                          onChanged: controller.selectStation,
                          selectedItemBuilder: (BuildContext context) {
                            return controller.stationsList
                                .map<Widget>((Station item) {
                              return Text(item.name);
                            }).toList();
                          },
                          items: controller.stationsList
                              .map<DropdownMenuItem<Station>>(
                                  (Station valueItem) {
                            return DropdownMenuItem(
                                value: valueItem,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      child: Text(
                                        valueItem.name,
                                        style: AppTextStyles.primarySlab17,
                                      ),
                                    ),
                                    Text(
                                      valueItem.description,
                                      style: AppTextStyles.primarySlab14,
                                    )
                                  ],
                                ));
                          }).toList(),
                        ),
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    splashColor: AppColors.accentColor,
                    onTap: () async {
                      await controller.changeLocation();
                      if (controller.updatedLocation.value == true) {
                        Navigator.pop(context, 'Cancel');
                        controller.updatedLocation.value = false;
                        controller.update();
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.accentColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10.0),
                        child: Text(
                          "Confirmer",
                          style: AppTextStyles.primarySlab20
                              .copyWith(color: AppColors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
