import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/components/ability_view.dart';
import 'package:UnderlordsGuru/app/ui/page/underlord_detail/underlord_detail.dart';
import 'package:UnderlordsGuru/app/model/pojo/underlord_talent.dart';

class TalentsView extends StatelessWidget {
  final UnderlordDetail underlord;

  TalentsView({this.underlord});

  @override
  Widget build(BuildContext context) {
    List<UnderlordTalent> talents = underlord.talents;

    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: talents.length,
      itemBuilder: (_, index) => AbilityView(
        name: talents[index].name,
        isTalent: true,
        talent: "Talent for: ${talents[index].forAbility}",
        effect: talents[index].effect,
        icon: talents[index].icon,
      ),
      separatorBuilder: (_, __) => SizedBox(height: 8.0),
    );
  }
}
