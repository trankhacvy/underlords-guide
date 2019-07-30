import 'package:UnderlordsGuru/app/model/pojo/underlord_ability.dart';
import 'package:UnderlordsGuru/app/model/pojo/underlord_talent.dart';

class UnderlordDetail {
  int id;
  String name;
  List<UnderlordAbility> abilities;
  List<UnderlordTalent> talents;

  UnderlordDetail({this.id, this.name, this.abilities, this.talents});

  @override
  String toString() {
    return "${this.name} - ${this.abilities[0].name} - ${this.abilities[0].icon}";
  }
}
