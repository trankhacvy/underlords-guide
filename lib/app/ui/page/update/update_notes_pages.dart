import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/model/pojo/patch.dart';
import 'package:UnderlordsGuru/app/ui/components/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/page/update/note_view.dart';

class UpdateNotesPage extends StatefulWidget {
  @override
  _UpdateNotesPageState createState() => _UpdateNotesPageState();
}

class _UpdateNotesPageState extends State<UpdateNotesPage> {
  List<Patch> _patches = [];
  bool _loading;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppStoreApplication application = AppProvider.of(context).application;
    setState(() {
      _loading = true;
    });
    application.dbAppStoreRepository.loadPatches().then((patches) {
      setState(() {
        patches.sort((patch1, patch2) => patch2.date.compareTo(patch1.date));
        _patches = patches;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Notes")),
      drawer: DrawerMenu(),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Transform.rotate(
                    angle: -0.1,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Image.asset('images/underlord_update.png'),
                    ),
                  ),
                  Transform.rotate(
                    angle: -0.1,
                    child: Text("UPDATE NOTES",
                        style: Theme.of(context).textTheme.title),
                  ),
                  SizedBox(height: 16.0),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _patches.length,
                    itemBuilder: (_, index) {
                      return NoteView(content: _patches[index].content);
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 16.0),
                  )
                ],
              ),
            ),
    );
  }
}
