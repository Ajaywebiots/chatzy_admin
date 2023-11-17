import '../../../config.dart';

class SearchAction extends StatelessWidget {
  const SearchAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(builder: (userCtrl) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (userCtrl.isSearch)
            SizedBox(
              width: Sizes.s500,
              child: TextField(
                  controller: userCtrl.txtSearch,
                  decoration: InputDecoration(
                      fillColor: appCtrl.appTheme.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r6),
                          borderSide:
                              BorderSide(color: appCtrl.appTheme.primary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r6),
                          borderSide:
                              BorderSide(color: appCtrl.appTheme.primary)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r6),
                          borderSide:
                              BorderSide(color: appCtrl.appTheme.primary)),
                      hintText: 'Enter search term based on name and Phone',
                      prefixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            userCtrl.isSearch = false;
                            userCtrl.txtSearch.text = "";
                            userCtrl.update();
                          }),
                      suffixIcon: IconButton(
                          icon:  Icon(Icons.search,color: appCtrl.appTheme.blackColor,), onPressed: () {})),
                  onSubmitted: (value) => userCtrl.filterData(value),
                  onChanged: (value) => userCtrl.filterData(value)),
            ),
          if (!userCtrl.isSearch)
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: appCtrl.appTheme.blackColor,
                ),
                onPressed: () {
                  userCtrl.isSearch = true;
                  userCtrl.update();
                })
        ],
      );
    });
  }
}
