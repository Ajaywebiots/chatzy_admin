import '../../../config.dart';
import '../../../models/usage_control_model.dart';

class UsageControlResponsive extends StatelessWidget {
  final UsageControlModel? configModel;

  const UsageControlResponsive({Key? key, this.configModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Responsive.isMobile(context) || Responsive.isTablet(context)
              // Mobile view
              ? UsageControlMobile(usageControlModel: configModel)
              // Desktop view
              : UsageControlDesktop(usageControlModel: configModel),
        ]));
  }
}
