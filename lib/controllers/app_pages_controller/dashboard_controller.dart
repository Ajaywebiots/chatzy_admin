import 'dart:async';
import 'dart:developer';

import '../../config.dart';

enum MessageType {
  text,
  image,
  video,
  doc,
  location,
  contact,
  audio,
  messageType,
  gif,
  link,
  imageArray,
  note,
  chatLoading
}

enum StatusType { text, image, video }

class DashboardController extends GetxController {
  int totalUser = 0;
  int totalCalls = 0;
  int videoCall = 0;
  int audioCall = 0;
  int totalIndiaUser = 0;
  int totalUsUser = 0;
  int totalPakistanUser = 0;
  int totalBangladeshUser = 0;
  int totalTurkeyUser = 0;
  int currentPage = 1;
  int lastVisible = 0;
  List<bool>? expanded;
  String? searchKey = "name";
  bool isDisplay =false;
  final List<StreamSubscription> _userSubscriptions = [];
  DocumentSnapshot? last;

  int lastLength = 0;
  // ignore: unused_field
  final String selectableKey = "id";
  String lastIndexId = "";
  final List<Map<String, dynamic>> sourceOriginal = [];
  List<Map<String, dynamic>> sourceFiltered = [];
  List<Map<String, dynamic>> source = [];
  String? sortColumn;
  dynamic lastVisibles;
  bool sortAscending = true;
  bool isLoading = true;
  List userList =[];
  final bool showSelect = true;
  int count =0;
  final List<int> perPages = [10, 20, 50, 100];
  int total = 100;
  int? currentPerPage = 10;
  TextEditingController textSearch = TextEditingController();
  QuerySnapshot? userQuerysnapshot;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection(collectionName.users);

  @override
  void onReady() async {
    totalIndiaUser = 0;
    totalUsUser = 0;
    totalPakistanUser = 0;
    totalBangladeshUser = 0;
    totalTurkeyUser = 0;
    totalUser = await FirebaseFirestore.instance
        .collection(collectionName.users)
        .get()
        .then((value) => value.size);
    total = totalUser;
    update();
    FirebaseFirestore.instance
        .collection(collectionName.users)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.asMap().entries.forEach((e) {
          if (e.value.data()["dialCode"] != null) {
            if (e.value.data()["dialCode"] == "+91") {
              totalIndiaUser++;
            }
            if (e.value.data()["dialCode"] == "+1") {
              totalUsUser++;
            }
            if (e.value.data()["dialCode"] == "+92") {
              totalPakistanUser++;
            } if (e.value.data()["dialCode"] == "+880") {
              totalBangladeshUser++;
            }if (e.value.data()["dialCode"] == "+90") {
              totalTurkeyUser++;
            }
          }
          FirebaseFirestore.instance
              .collection(collectionName.calls)
              .doc(e.value.id)
              .collection(collectionName.collectionCallHistory)
              .get()
              .then((value) {
            totalCalls = totalCalls + value.docs.length;
            value.docs.asMap().forEach((key, value) {
              if (value.data()["isVideoCall"] != null &&
                  value.data()["isVideoCall"] == true) {
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
    update();
    usersCollection.get().then((value){
      lastLength = value.docs.length;
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

    Future.delayed(const Duration(seconds: 3)).then((value) {
      isDisplay =true;
      update();
    });
    update();
    // TODO: implement onReady
    super.onReady();
  }

  bool loading = true;
  double progressValue = 0;

  final List<Map<String, dynamic>> listItem = [
    {'title': "totalUser", 'icon': svgAssets.groups},
    {'title': 'totalCalls', 'icon': svgAssets.call},
    {'title': 'videoCalls', 'icon': svgAssets.videoCall},
    {'title': 'audioCalls', 'icon': svgAssets.audioCall},
  ];


  Stream searchList() {
    Stream<QuerySnapshot<Map<String, dynamic>>> event = FirebaseFirestore
        .instance
        .collection(collectionName.users)
        .orderBy('name').where("name",isGreaterThanOrEqualTo: textSearch.text)
        .startAfterDocument(last!)
        .limit(currentPerPage!)

        .snapshots();

    return event;
  }

  userActiveDeActive(id, val) async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest);
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      await FirebaseFirestore.instance
          .collection(collectionName.users)
          .doc(id)
          .update({"isActive": val});
    }
  }

  deleteData(id) async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest);
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      await FirebaseFirestore.instance
          .collection(collectionName.calls)
          .doc(id)
          .delete();
      await FirebaseFirestore.instance
          .collection(collectionName.users)
          .doc(id)
          .collection(collectionName.status)
          .get()
          .then((value) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> ds in value.docs) {
          Status status = Status.fromJson(ds.data());
          List<PhotoUrl> photoUrl = status.photoUrl ?? [];
          for (var list in photoUrl) {
            if (list.statusType == StatusType.image.name ||
                list.statusType == StatusType.video.name) {
              FirebaseStorage.instance.refFromURL(list.image!).delete();
            }
          }
        }
      });
      await FirebaseFirestore.instance
          .collection(collectionName.users)
          .doc(id)
          .collection(collectionName.chats)
          .get()
          .then((value) {
        for (DocumentSnapshot ds in value.docs) {
          ds.reference.delete();
        }
      });
      await FirebaseFirestore.instance
          .collection(collectionName.users)
          .doc(id)
          .collection(collectionName.messages)
          .get()
          .then((value) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> ds in value.docs) {
          if (ds.data()["type"] == MessageType.image.name ||
              ds.data()["type"] == MessageType.audio.name ||
              ds.data()["type"] == MessageType.video.name ||
              ds.data()["type"] == MessageType.doc.name ||
              ds.data()["type"] == MessageType.gif.name ||
              ds.data()["type"] == MessageType.imageArray.name) {
            String url = decryptMessage(ds.data()["content"]);
            FirebaseStorage.instance
                .refFromURL(
                url.contains("-BREAK-") ? url.split("-BREAK-")[0] : url)
                .delete();
          }
          ds.reference.delete();
        }
      });
      await FirebaseFirestore.instance
          .collection(collectionName.users)
          .doc(id)
          .collection(collectionName.groupMessage)
          .get()
          .then((value) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> ds in value.docs) {
          if (ds.data()["type"] == MessageType.image.name ||
              ds.data()["type"] == MessageType.audio.name ||
              ds.data()["type"] == MessageType.video.name ||
              ds.data()["type"] == MessageType.doc.name ||
              ds.data()["type"] == MessageType.gif.name ||
              ds.data()["type"] == MessageType.imageArray.name) {
            String url = decryptMessage(ds.data()["content"]);
            FirebaseStorage.instance
                .refFromURL(
                url.contains("-BREAK-") ? url.split("-BREAK-")[0] : url)
                .delete();
          }
          ds.reference.delete();
        }
      });

      await FirebaseFirestore.instance
          .collection(collectionName.users)
          .doc(id)
          .collection(collectionName.broadcastMessage)
          .get()
          .then((value) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> ds in value.docs) {
          if (ds.data()["type"] == MessageType.image.name ||
              ds.data()["type"] == MessageType.audio.name ||
              ds.data()["type"] == MessageType.video.name ||
              ds.data()["type"] == MessageType.doc.name ||
              ds.data()["type"] == MessageType.gif.name ||
              ds.data()["type"] == MessageType.imageArray.name) {
            String url = decryptMessage(ds.data()["content"]);
            FirebaseStorage.instance
                .refFromURL(
                url.contains("-BREAK-") ? url.split("-BREAK-")[0] : url)
                .delete();
          }
          ds.reference.delete();
        }
      });

      await FirebaseFirestore.instance
          .collection(collectionName.users)
          .doc(id)
          .delete();
    }
  }

  //reset data
  resetData({start = 0}) async {
    isLoading = true;
    update();
    var expandedLen =
    total - start < currentPerPage! ? total - start : currentPerPage;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      expanded = List.generate(expandedLen as int, (index) => false);
      source.clear();
      // source = sourceFiltered.getRange(start, start + expandedLen).toList();
      isLoading = false;
      update();
    });
  }

  //filter data
  filterData(value) {
    isLoading = true;
    update();
    try {
      if (value == "" || value == null) {
        sourceFiltered = sourceOriginal;
      } else {
        sourceFiltered = sourceOriginal.where((data) {
          log("DA :$data");
          return data[searchKey!]
              .toString()
              .toLowerCase()
              .contains(value.toString().toLowerCase()) ||
              data["name"]
                  .toString()
                  .toLowerCase()
                  .contains(value.toString().toLowerCase());
        }).toList();
      }

      total = sourceFiltered.length;
      var rangeTop = total < currentPerPage! ? total : currentPerPage!;
      expanded = List.generate(rangeTop, (index) => false);
      source = sourceFiltered.getRange(0, rangeTop).toList();
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }



  void addToUsers(QuerySnapshot event) {
    for (final userDoc in event.docs) {
      dynamic user = userDoc.data();
      final index = userList.indexWhere((element){
        log("USER: ${element}");
        log("USER: $user");
        return  user!["id"] == element["id"];
      });
      if (index != -1) {
        userList.removeAt(index);
        userList.insert(index, user);
      } else {
        userList.add(user);
      }
    }
  }
  List<List<QueryDocumentSnapshot<dynamic>>> allPagedResults = [];

  bool _hasMoreData = true;
  StreamController chatController =
  StreamController.broadcast();

  Stream listenToChatsRealTime({bool? isPrevious}) {
    _requestChats(isPrevious: isPrevious);
    return chatController.stream;
  }

  void _requestChats({bool? isPrevious}) {
    allPagedResults = [];
    if(count <=0) {
      count ++;
      var pagechatQuery = FirebaseFirestore.instance
          .collection(collectionName.users).orderBy("name")
          .limit(currentPerPage!);
      log("isPrevious: $isPrevious");
      log("isPrevious: $last");
      log("isPrevious: $last");
      if (last != null) {
        if(isPrevious == null){
          pagechatQuery =
              pagechatQuery .limit(currentPerPage!);
        }else if(isPrevious == true){
          _hasMoreData =true;
          pagechatQuery =
              pagechatQuery.endBeforeDocument(last!);
        }else     {
          _hasMoreData =true;
          pagechatQuery =
              pagechatQuery.startAfterDocument(last!).limit(currentPerPage!);
        }

      }


      if (!_hasMoreData) return;

      var currentRequestIndex = allPagedResults.length;
      log("currentRequestIndex:$currentRequestIndex");

      pagechatQuery.snapshots().listen(
            (snapshot) {
          if (snapshot.docs.isNotEmpty) {
            log("snapshot.docs::${snapshot.docs.length}");
            var generalChats = snapshot.docs;

            var pageExists = currentRequestIndex < allPagedResults.length;

            if (pageExists) {
              allPagedResults[currentRequestIndex] = generalChats;
            } else {
              allPagedResults.add(generalChats);
            }

            var allChats = allPagedResults.fold([],
                    (initialValue, pageItems) =>
                initialValue
                  ..addAll(pageItems));

            chatController.add(allChats);
            log("allPagedResults.length - 1: ${currentRequestIndex == allPagedResults.length - 1}");
            if (currentRequestIndex == allPagedResults.length - 1) {
              last = snapshot.docs.last;
            }

            _hasMoreData = generalChats.length == currentPerPage;
          }
        },

      );

      log("last: $last");
    }
  }


  void requestMoreData() => _requestChats();


}