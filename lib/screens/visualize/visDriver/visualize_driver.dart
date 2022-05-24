import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/visualize/visDriver/visualize_controller_driver.dart';
import 'package:softun_bus_mobile/screens/visualize/visualize_controller.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class VisualizeDriverPage extends StatefulWidget {
  const VisualizeDriverPage({Key? key}) : super(key: key);

  @override
  State<VisualizeDriverPage> createState() => _VisualizeDriverPageState();
}

class _VisualizeDriverPageState extends State<VisualizeDriverPage> {
  final visController = Get.put(VisualizeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Map"),
        backgroundColor: AppColors.accentColor,
      ),
      body: ConnectivityContainer(
        child: GetBuilder<VisualizeDriverController>(
            init: VisualizeDriverController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingVis.value
                  ? CustomLoader()
                  : Stack(
                      children: [
                        OSMFlutter(
                          controller: controller.mapController,
                          trackMyPosition: false,
                          initZoom: 11,
                          minZoomLevel: 8,
                          maxZoomLevel: 16,
                          stepZoom: 1.0,
                          userLocationMarker: UserLocationMaker(
                            personMarker: MarkerIcon(
                              icon: Icon(
                                Icons.location_history_rounded,
                                color: Colors.pink,
                                size: 200,
                              ),
                            ),
                            directionArrowMarker: MarkerIcon(
                              icon: Icon(
                                Icons.double_arrow,
                                size: 200,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          // roadConfiguration: RoadConfiguration(
                          //   startIcon: MarkerIcon(
                          //     icon: Icon(
                          //       Icons.person,
                          //       size: 64,
                          //       color: Colors.brown,
                          //     ),
                          //   ),
                          //   roadColor: Colors.yellowAccent,
                          // ),
                          markerOption: MarkerOption(
                              defaultMarker: MarkerIcon(
                            icon: Icon(
                              Icons.person_pin_circle,
                              color: Colors.blue,
                              size: 56,
                            ),
                          )),
                        ),
                        Column(
                          children: [
                            RaisedButton(
                              child: Text("Voir circuit "),
                              onPressed: () async {
                                RoadInfo roadInfo =
                                    await controller.mapController.drawRoad(
                                  GeoPoint(
                                      latitude: 36.83189972628371,
                                      longitude: 10.232979910714306), //Sofrecom
                                  GeoPoint(
                                      latitude: 36.826914001839285,
                                      longitude:
                                          10.193816593715127), //Hay Khadhra
                                  roadOption: RoadOption(
                                    roadColor: AppColors.blue,
                                    roadWidth: 20,
                                  ),
                                );
                                print("${roadInfo.distance}km");
                                print("${roadInfo.duration}sec");
                              },
                            ),
                            RaisedButton(
                              child: Text("Mark stations"),
                              onPressed: () async {
                                await controller.drawStationsMarkers(
                                    controller.chosenCircuit!.station);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}
