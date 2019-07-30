import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';

class HeroByTier {
  bool isHeader;
  String header;
  HeroModel hero;

  HeroByTier.isHeader({this.header, this.isHeader = true});

  HeroByTier.isHero({this.hero, this.isHeader = false});
  
}
