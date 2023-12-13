

import '../../../config.dart';

class WallpaperListTable extends StatelessWidget {
  final List<TableRow>? children;
  const WallpaperListTable({Key? key,this .children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.r6),
      child: Table(

        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        children: children!,
      ).decorated(

          borderRadius: BorderRadius.circular(AppRadius.r5)),
    );
  }
}
