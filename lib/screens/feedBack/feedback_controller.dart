import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/demande_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/feedback_model.dart';
import 'package:softun_bus_mobile/models/token_model.dart';
import 'package:softun_bus_mobile/services/api/feedback_api.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

class FeedBackController extends GetxController {
  SharedPreferenceService sharedPreferenceService = Get.find();
  FeedbackService feedbackApi = Get.find();

  GlobalKey<FormState> formKeyFeedback = GlobalKey<FormState>();

  var descriptionController = TextEditingController(),
      titleController = TextEditingController();

  late List<Feedback> feedbackList;
  var isLoadingFeedback = false.obs;
  final step = FeedBackStep.feedbackList.obs;

  String? validateEmpty(value) {
    if (value != null) {
      if (!value.isEmpty) {
        return null;
      }
    }
    return 'Veuillez remplir ce champs.';
  }

  @override
  onInit() async {
    // TODO: implement onInit
    super.onInit();
    // await getFeedbacks();
  }

  getFeedbacks() async {
    try {
      isLoadingFeedback(true);
      print("getRequests...");

      var t = await getAccessToken();
      var response = await feedbackApi.getUserFeedbacks(token: t);
      print(response.data);

      feedbackList =
          List<Feedback>.from(response.data.map((x) => Demande.fromJson(x)));
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    } finally {
      isLoadingFeedback(false);
      update();
    }
  }

  getAccessToken() async {
    var s = await sharedPreferenceService.getString("token");
    var token = Token.fromJson(json.decode(s)).access_token;

    return token;
  }

  sendFeedback() async {
    try {
      // to check the all the condition of the appTextField
      if (!formKeyFeedback.currentState!.validate()) {
        print("form Add station not valideee");
        return;
      }
      Feedback f = Feedback(
        date: "",
        titre: titleController.text,
        description: descriptionController.text,
      );

      var t = await getAccessToken();
      // var response = await feedbackApi.addFeedback(
      //   token: t,
      //   feedBack: f,
      // );

      step.value = FeedBackStep.feedbackSucces;
      // await getFeedbacks();
      update();
    } catch (error) {
      print(error.toString());
      getErrorSnackBar(title: "Oops!", message: error.toString());
    }
  }
}
