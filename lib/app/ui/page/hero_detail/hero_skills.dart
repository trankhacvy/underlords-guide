import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';

class HeroSkills extends StatelessWidget {
  final HeroModel hero;

  HeroSkills({this.hero});

  @override
  Widget build(BuildContext context) {
    var abilities = hero.abilities;
    return Container(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.0),
        itemCount: hero.tier == 'Ace' ? abilities.length + 1 : abilities.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return hero.tier == 'Ace'
                ? _buildCard(
                    context,
                    Ability(
                        name: hero.aceEffect.type,
                        icon: 'images/ic_ace_hero.png',
                        effect: hero.aceEffect.effect))
                : _buildCard(context, abilities[0]);
          }
          return hero.tier == 'Ace'
              ? _buildCard(context, abilities[index - 1])
              : _buildCard(context, abilities[index]);
        },
      ),
    );
  }

  Widget _buildCard(context, Ability ability) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
                ability.id != null ? ability.getIcon() : ability.icon,
                width: 80,
                height: 80),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(ability.name, style: Theme.of(context).textTheme.title),
                  SizedBox(height: 8.0),
                  ability.cooldown != ''
                      ? Row(
                          children: <Widget>[
                            Image.asset('images/ic_cooldown.png',
                                width: 24, height: 24),
                            SizedBox(width: 4.0),
                            Text(ability.cooldown)
                          ],
                        )
                      : Container(),
                  SizedBox(height: 8.0),
                  ability.manaCost != ''
                      ? Row(
                          children: <Widget>[
                            Image.asset('images/ic_mana_cost.png',
                                width: 24, height: 24),
                            SizedBox(width: 4.0),
                            Text(ability.manaCost)
                          ],
                        )
                      : Container(),
                  SizedBox(height: 8.0),
                  Text(ability.effect),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
