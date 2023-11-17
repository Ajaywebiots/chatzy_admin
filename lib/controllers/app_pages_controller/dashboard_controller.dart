import 'dart:async';

import '../../config.dart';

class DashboardController extends GetxController{
  int totalUser = 0;
  int totalCalls = 0;
  int videoCall = 0;
  int audioCall = 0;

  @override
  void onReady() async{
    totalUser = await FirebaseFirestore.instance.collection(collectionName.users).get().then((value) => value.size);

    FirebaseFirestore.instance.collection(collectionName.users).get().then((value) {
      if(value.docs.isNotEmpty) {
        value.docs
            .asMap()
            .entries
            .forEach((e) {
          FirebaseFirestore.instance
              .collection(collectionName.calls)
              .doc(e.value.id)
              .collection(collectionName.collectionCallHistory)
              .get().then((value) {
            totalCalls = totalCalls + value.docs.length;
            value.docs.asMap().forEach((key, value) {
                if(value.data()["isVideoCall"] != null &&  value.data()["isVideoCall"] == true) {
                  videoCall++;
                } else {
                  audioCall++;
                }
            });
            update();
          });
        });
      }
    });

    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) async {
        progressValue += 0.1;
        // we "finish" downloading here
        if (progressValue.toStringAsFixed(1) == '1.0') {
          loading = false;
          t.cancel();
          return;
        }
    });

  update();

    // TODO: implement onReady
    super.onReady();
  }
  bool loading = true;
  double progressValue = 0;

  final List<Map<String, dynamic>> listItem = [
    {
      'title': "totalUser",
      'icon': svgAssets.groups
    },
    {
      'title': 'totalCalls',
      'icon': svgAssets.call
    },
    {
      'title': 'videoCalls',
      'icon': svgAssets.videoCall
    },
    {
      'title': 'audioCalls',
      'icon': svgAssets.audioCall
    },
  ];
}