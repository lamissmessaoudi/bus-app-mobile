import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/trajet_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';
import 'package:softun_bus_mobile/services/api/stations_api.dart';
import 'package:softun_bus_mobile/services/api/visualization_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';

class VisualizeColabController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  StationService stationApi = Get.find();
  VisualisationService visService = Get.find();

  final homeController = Get.put(HomeColabController());

  var c = false.obs;
  late User user;
  late Trajet? chosenTrajet;

  var isLoadingVis = false.obs;

  MapController mapController = MapController(
    initMapWithUserPosition: true,
  );

  @override
  onInit() async {
    super.onInit();
    chosenTrajet = homeController.chosenTrajet;
  }
}
