import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:schoolapp/imports.dart';
import 'package:http/http.dart' as http;

class NotesView extends StatefulWidget {
  bool isPdf = true;
  String filePath = "";

  NotesView(this.isPdf, this.filePath);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    super.initState();
    print(Constants.ROOT + "notes/uploads/" + widget.filePath);
  }

  @override
  Widget build(BuildContext context) {
    return ConstantsWidget.getBasicScreen(
        context,
        Column(
          children: [
            ConstantsWidget.getBasicAppBar(
                Icon(Icons.arrow_back), "Notes", null),
            Expanded(
              child: Container(
                width: double.infinity,
                child: widget.isPdf
                    ? PDF(
                        swipeHorizontal: true,
                      ).cachedFromUrl(
                        Constants.ROOT + "notes/uploads/" + widget.filePath)
                    : PhotoView(
                  backgroundDecoration: BoxDecoration(color: Constants.backgroundgrey),
                        imageProvider: NetworkImage(Constants.ROOT +
                            "notes/uploads/" +
                            widget.filePath)),
              ),
            ),
          ],
        ));
  }
}
