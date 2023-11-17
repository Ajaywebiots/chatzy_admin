import '../../../config.dart';

class SelectedIndexBodyLayout extends StatelessWidget {
  const SelectedIndexBodyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(builder: (indexCtrl) {
      return Expanded(
          child: SelectionArea(
              child: CustomScrollView(
                  shrinkWrap: true,
                  controller: indexCtrl.scrollController,
                  slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                  color: appCtrl.isTheme ?appCtrl.appTheme.whiteColor : appCtrl.appTheme.bgColor,
                  padding: const EdgeInsets.symmetric(horizontal: Insets.i24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const VSpace(Sizes.s20),
                        indexCtrl.widgetOptions
                            .elementAt(indexCtrl.selectedIndex)
                      ]))
            ])),
            SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: const Column(children: <Widget>[
                  Expanded(child: SizedBox.shrink())
                ]).backgroundColor(appCtrl.isTheme ?appCtrl.appTheme.whiteColor : appCtrl.appTheme.bgColor,))
          ])));
    });
  }
}
