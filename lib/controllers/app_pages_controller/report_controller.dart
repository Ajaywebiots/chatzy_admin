import 'dart:developer' as log;

import 'dart:math';

import '../../config.dart';

class ReportController extends GetxController {
  final List<int> perPages = [10, 20, 50, 100];
  int total = 100;
  int? currentPerPage = 10;
  List<bool>? expanded;
  String? searchKey = "email";
  XFile? imageFile;
  int currentPage = 1;
  bool isSearch = false, isUploadSize = false, isAlert = false;
  final List<Map<String, dynamic>> sourceOriginal = [];
  List<Map<String, dynamic>> sourceFiltered = [];
  List<Map<String, dynamic>> source = [];
  int lastVisible = 0;

  TextEditingController txtSearch = TextEditingController();
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtId = TextEditingController();

  // ignore: unused_field
  final String selectableKey = "id";
  String lastIndexId = "";

  String? sortColumn;

  bool sortAscending = true;
  bool isLoading = true;
  final bool showSelect = true;

  var random = Random();

  //reset data
  resetData({start = 0}) async {
    isLoading = true;
    update();
    var expandedLen =
        total - start < currentPerPage! ? total - start : currentPerPage;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      expanded = List.generate(expandedLen as int, (index) => false);
      source.clear();
      source = sourceFiltered.getRange(start, start + expandedLen).toList();
      isLoading = false;
      update();
    });
  }

  Stream getChatsFromRefs() {
    log.log("txtSearch.text : ${txtSearch.text}");
    log.log("txtSearch.text : $lastIndexId");
    Stream<QuerySnapshot<Map<String, dynamic>>> event = FirebaseFirestore
        .instance
        .collection(collectionName.users)
        .where("email", isGreaterThanOrEqualTo: txtSearch.text)

        .limit(currentPerPage!)
        .snapshots();
    return event;
  }

  //filter data
  filterData(value) {
    isLoading = true;
    update();
    getChatsFromRefs();
    try {
      if (value == "" || value == null) {
        sourceFiltered = sourceOriginal;
      } else {
        sourceFiltered = sourceOriginal
            .where((data) =>
                data[searchKey!]
                    .toString()
                    .toLowerCase()
                    .contains(value.toString().toLowerCase()) ||
                data["phone"]
                    .toString()
                    .toLowerCase()
                    .contains(value.toString().toLowerCase()))
            .toList();
      }

      total = sourceFiltered.length;
      var rangeTop = total < currentPerPage! ? total : currentPerPage!;
      expanded = List.generate(rangeTop, (index) => false);
      source = sourceFiltered.getRange(0, rangeTop).toList();
    } catch (e) {
      log.log("filter error : $e");
    }
    isLoading = false;
    update();
  }
}
