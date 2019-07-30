import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/pojo/alliance.dart';
import 'package:UnderlordsGuru/app/ui/page/alliance_detail/alliance_detail.dart';

class AllianceView extends StatelessWidget {
  final Alliance _alliance;

  AllianceView({alliance}) : _alliance = alliance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppProvider.getRouter(context).navigateTo(
            context,
            AllianceDetailPage.generatePath(
                _alliance.id.toString(), _alliance.name, _alliance.icon),
            transition: TransitionType.fadeIn);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(29, 29, 29, 1),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _alliance.icon,
              fit: BoxFit.cover,
              width: 64,
              height: 64,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Hero(
                tag: "alliance_${_alliance.id}",
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(_alliance.name,
                      style: Theme.of(context).textTheme.body2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
