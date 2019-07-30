import "package:flutter/material.dart";
import 'package:github/github.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

List<IssueLabel> issueLabels = [
  IssueLabel("Bug", "bug"),
  IssueLabel("Enhancement", "enhancement"),
  IssueLabel("Question", "question"),
  IssueLabel("Help", "help wanted"),
];

class IssueLabel {
  String name;
  String value;
  IssueLabel(name, value) {
    this.name = name;
    this.value = value;
  }
}

void showSendFeedbackDialog(context) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (_, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: CustomDialog(),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (_, __, ___) {
        return Container();
      });
}

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String _label = 'enhancement';
  bool _loading = false;

  void sendFeedback() async {
    if (_formKey.currentState.validate()) {
      String title = _titleController.text;
      String comment = _commentController.text;
      var github =
          GitHub(auth: Authentication.withToken(DotEnv().env['GITHUB_TOKEN']));
      var slug = RepositorySlug(
          DotEnv().env['GITHUB_USERNAME'], DotEnv().env['GITHUB_REPO']);
      var issue = IssueRequest(title: title, body: comment, labels: [_label]);
      setState(() {
        _loading = true;
      });
      await github.issues.create(slug, issue);
      setState(() {
        _loading = false;
      });
      await Future.delayed(Duration(milliseconds: 300));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: new BoxDecoration(
          color: Theme.of(context).backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "Title"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _commentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                decoration: InputDecoration(
                  hintText: "Your comment",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Comment is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              DropdownButton<String>(
                value: _label,
                hint: Text("Select labels"),
                items: issueLabels.map((IssueLabel label) {
                  return new DropdownMenuItem<String>(
                    value: label.value,
                    child: new Text(label.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _label = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              RaisedButton(
                onPressed: sendFeedback,
                child: _loading
                    ? Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text("Send"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
