import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/components/nullable_view.dart';

class AbilityView extends StatelessWidget {
  final String icon;
  final String name;
  final String cooldown;
  final String cost;
  final String effect;
  final String type;
  final bool isTalent;
  final String talent;

  AbilityView(
      {this.name,
      this.icon,
      this.type = '',
      this.cooldown = '',
      this.cost = '',
      this.effect = '',
      this.talent = '',
      this.isTalent = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              icon,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name, style: Theme.of(context).textTheme.title),
                  SizedBox(height: 8.0),
                  NullableView(
                      condition: cooldown != '' && !isTalent,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset('images/ic_cooldown.png',
                                width: 24, height: 24),
                            SizedBox(width: 4.0),
                            Text(cooldown)
                          ],
                        ),
                      )),
                  NullableView(
                      condition: cost != '' && !isTalent,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset('images/ic_mana_cost.png',
                                width: 24, height: 24),
                            SizedBox(width: 4.0),
                            Text(cost)
                          ],
                        ),
                      )),
                  NullableView(
                      condition: type != '',
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset('images/ic_mana_cost.png',
                                width: 24, height: 24),
                            SizedBox(width: 4.0),
                            Text(type)
                          ],
                        ),
                      )),
                  NullableView(
                      condition: talent != '' && isTalent,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset('images/ic_mana_cost.png',
                                width: 24, height: 24),
                            SizedBox(width: 4.0),
                            Expanded(
                              child: Text(talent),
                            )
                          ],
                        ),
                      )),
                  Text(effect),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
