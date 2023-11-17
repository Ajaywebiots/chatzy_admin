import 'dart:developer';
import '../config.dart';

class DragDropLayout extends StatelessWidget {
  final DropzoneViewCreatedCallback? onCreated;
  final ValueChanged<dynamic>? onDrop;
  const DragDropLayout({Key? key,this.onCreated,this.onDrop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => DropzoneView(

            operation: DragOperation.copy,
            cursor: CursorType.grab,
            onCreated: onCreated,
            onLoaded: () => log('Zone 1 loaded'),
            onError: (ev) => log('Zone 1 error: $ev'),
            onHover: () {
              log('Zone 1 hovered');
            },
            onLeave: () {
              log('Zone 1 left');
            },
            onDrop: onDrop,
            onDropMultiple: (ev) async {
              log('Zone 1 drop multiple: $ev');
            }));
  }
}
