import 'package:UnderlordsGuru/app/model/pojo/underlord_ability.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/components/ability_view.dart';
import 'package:UnderlordsGuru/app/ui/page/underlord_detail/underlord_detail.dart';

class AbilitiesView extends StatelessWidget {
  final UnderlordDetail underlord;

  AbilitiesView({this.underlord});

  @override
  Widget build(BuildContext context) {
    List<UnderlordAbility> abilities = underlord.abilities;

    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: abilities.length,
      itemBuilder: (_, index) => AbilityView(
        name: abilities[index].name,
        cooldown: abilities[index].cooldown,
        cost: abilities[index].hypeRequirement,
        effect: abilities[index].effect,
        icon: abilities[index].icon,
      ),
      separatorBuilder: (_, __) => SizedBox(height: 8.0),
    );
  }
}
