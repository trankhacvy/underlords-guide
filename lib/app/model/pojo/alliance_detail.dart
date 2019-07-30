import 'package:UnderlordsGuru/app/model/pojo/alliance.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';

class AllianceDetail {
  Alliance alliance;
  List<HeroModel> heroes;

  AllianceDetail({this.alliance, this.heroes});

  @override
  String toString() {
    return "name: ${this.alliance.name} heroes: ${this.heroes.length}";
  }
}
