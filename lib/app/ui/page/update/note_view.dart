import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:UnderlordsGuru/utility/colors.dart';

class NoteView extends StatelessWidget {
  final String content;

  NoteView({this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Html(
        data: content,
        useRichText: true,
        padding: EdgeInsets.all(16.0),
        customRender: (node, children) {
          if (node is dom.Element) {
            if (node.localName == 'div' && node.id == 'Form') {
              return Container(
                color: Colors.redAccent,
                child: Column(
                  children: children,
                ),
              );
            }
            switch (node.localName) {
              case "form":
                return Container(
                  color: Colors.redAccent,
                  child: Column(
                    children: children,
                  ),
                );
            }
          }
          return null;
        },
        customTextStyle: (dom.Node node, TextStyle baseStyle) {
          if (node is dom.Element) {
            if (node.localName == 'div' &&
                node.className.indexOf("PatchDate") >= 0) {
              return baseStyle
                  .merge(TextStyle(fontSize: 18, color: HexColor('#777777')));
            } else if (node.localName == 'div' &&
                node.className.indexOf('PatchTitle') >= 0) {
              return baseStyle.merge(TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: HexColor('#dedede')));
            } else if (node.localName == 'div' &&
                node.className.indexOf('bb_h1') >= 0) {
              return baseStyle
                  .merge(TextStyle(fontSize: 16, color: HexColor('#5aa9d6')));
            }
          }
          return baseStyle;
        },
      ),
    );
  }
}
