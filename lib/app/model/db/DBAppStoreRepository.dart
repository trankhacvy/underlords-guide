import 'package:UnderlordsGuru/app/model/pojo/guide.dart';
import 'package:UnderlordsGuru/app/model/pojo/patch.dart';
import 'package:sqflite/sqflite.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/model/pojo/alliance.dart';
import 'package:UnderlordsGuru/app/model/pojo/alliance_detail.dart';
import 'package:UnderlordsGuru/app/model/pojo/item.dart';
import 'package:UnderlordsGuru/app/model/pojo/underlord.dart';
import 'package:UnderlordsGuru/app/ui/page/underlord_detail/underlord_detail.dart';
import 'package:UnderlordsGuru/app/model/pojo/underlord_ability.dart';
import 'package:UnderlordsGuru/app/model/pojo/underlord_talent.dart';

class DBAppStoreRepository {
  Database _database;

  DBAppStoreRepository(this._database);

  Future<List<HeroModel>> loadHeroes() async {
    List<Map> list =
        await _database.rawQuery("SELECT * FROM heroes ORDER BY `name` ASC");
    List<HeroModel> heroes = [];
    HeroModel hero;
    for (var map in list) {
      hero = HeroModel.fromJson(map);
      heroes.add(hero);
    }
    return heroes;
  }

  Future<List<HeroModel>> getHeroesSameAlliance(
      int heroId, String alliance) async {
    List<Map> list = await _database.rawQuery(
        "SELECT * FROM heroes where alliances LIKE '%$alliance%' AND id <> $heroId  ORDER BY `name` ASC");
    List<HeroModel> heroes = [];
    HeroModel hero;
    for (var map in list) {
      hero = HeroModel.fromJson(map);
      heroes.add(hero);
    }
    return heroes;
  }

  Future<Map<String, List<HeroModel>>> find(
      int heroId, List<String> alliances) async {
    var futures = <Future<List<HeroModel>>>[];
    for (var alliance in alliances) {
      futures.add(getHeroesSameAlliance(heroId, alliance));
    }
    List<List<HeroModel>> heroes = await Future.wait(futures);
    if (heroes != null && heroes.length > 0) {
      Map<String, List<HeroModel>> result = {};
      for (var i = 0; i < alliances.length; i++) {
        result[alliances[i]] = heroes[i];
      }

      return result;
    }
    return null;
  }

  Future<HeroModel> findHeroById(int id) async {
    List<Map> maps =
        await _database.rawQuery("SELECT * FROM heroes where id = '$id' ");
    if (maps.length > 0) {
      HeroModel hero = HeroModel.fromJson(maps.first);
      // query abilities
      List<Map> list = await _database
          .rawQuery("SELECT * FROM abilities where heroId = '$id' ");
      List<Ability> abilities = [];
      Ability ability;
      for (var map in list) {
        ability = Ability.fromJson(map);
        abilities.add(ability);
      }
      hero.abilities = abilities;

      return hero;
    }
    return null;
  }

  Future<List<Alliance>> loadAlliances() async {
    String query = """
  SELECT alliances.*,
       group_concat(alliancesBonuses.id, ",") AS alliancesBonusesIds,
       group_concat(alliancesBonuses.description, ",") AS alliancesBonusesDescriptions,
       group_concat(alliancesBonuses.requiredHeroes, ",") AS alliancesBonusesRequiredHeroes
  FROM alliances
  LEFT JOIN alliancesBonuses ON alliances.id = alliancesBonuses.allianceId
  GROUP BY alliances.id
  ORDER BY alliances.name DESC;
      """;

    List<Map> list = await _database.rawQuery(query);
    List<Alliance> alliances = [];
    Alliance alliance;
    for (var map in list) {
      alliance = Alliance.fromJson(convertMap(Map.from(map)));
      alliances.add(alliance);
    }
    return alliances;
  }

  convertMap(Map<String, dynamic> map) {
    String bonusIdsStr = map['alliancesBonusesIds'];
    String bonusDessStr = map['alliancesBonusesDescriptions'];
    String bonusRequireHeroessStr = map['alliancesBonusesRequiredHeroes'];

    List<String> bonusIds = bonusIdsStr.split(",");
    List<String> bonusDes = bonusDessStr.split(",");
    List<String> bonusRequireHeroes = bonusRequireHeroessStr.split(",");
    List<Map<String, dynamic>> allianceBonuses = [];
    for (var i = 0; i < bonusIds.length; i++) {
      allianceBonuses.add({
        "id": int.parse(bonusIds[i]),
        "description": bonusDes[i],
        "requiredHeroes": int.parse(bonusRequireHeroes[i]),
      });
    }
    map['allianceBonuses'] = allianceBonuses;

    return map;
  }

  Future<AllianceDetail> findAllianceById(int id) async {
    List<Map> allianceMaps =
        await _database.rawQuery("SELECT * FROM alliances where id = '$id' ");
    if (allianceMaps.length > 0) {
      Alliance alliance = Alliance.fromJson(allianceMaps.first);
      // query bonuses
      List<Map> bonusMaps = await _database
          .rawQuery("SELECT * FROM alliancesBonuses where allianceId = '$id' ");
      List<AllianceBonus> bonuses = [];
      AllianceBonus bonus;
      for (var map in bonusMaps) {
        bonus = AllianceBonus.fromJson(map);
        bonuses.add(bonus);
      }
      alliance.allianceBonuses = bonuses;

      // query relative heroes
      List<Map> heroMaps = await _database.rawQuery(
          "SELECT id, name, alliances, icon, tier FROM heroes where alliances LIKE '%${alliance.name}%'  ");
      List<HeroModel> heroes = [];
      HeroModel hero;
      for (var map in heroMaps) {
        hero = HeroModel.fromJson(map);
        heroes.add(hero);
      }

      return AllianceDetail(alliance: alliance, heroes: heroes);
    }
    return null;
  }

  Future<List<Item>> loadItems() async {
    List<Map> list =
        await _database.rawQuery("SELECT * from items  ORDER BY items.name;");
    List<Item> items = [];
    Item item;
    for (var map in list) {
      item = Item.fromJson(map);
      items.add(item);
    }
    return items;
  }

  Future<List<Underlord>> loadUnderlords() async {
    List<Map> list = await _database
        .rawQuery("SELECT * FROM underlords ORDER BY `name` ASC");
    List<Underlord> underlords = [];
    Underlord underlord;
    for (var map in list) {
      underlord = Underlord.fromJson(map);
      underlords.add(underlord);
    }
    return underlords;
  }

  Future<UnderlordDetail> findUnderlordByid(int id) async {
    List<Map> list =
        await _database.rawQuery("SELECT * FROM underlords where id = '$id' ");

    if (list.length > 0) {
      Underlord underlord = Underlord.fromJson(list.first);
      // query abilities
      List<Map> abilitiesList = await _database.rawQuery(
          "SELECT * FROM underlordAbilities where underlordId = '$id' ");
      List<UnderlordAbility> underlordAbilities = [];
      UnderlordAbility ability;
      for (var map in abilitiesList) {
        ability = UnderlordAbility.fromJson(map);
        underlordAbilities.add(ability);
      }

      // query talents
      List<Map> talentsList = await _database.rawQuery(
          "SELECT * FROM underlordTalents where underlordId = '$id' ");
      List<UnderlordTalent> underlordTalents = [];
      UnderlordTalent talent;
      for (var map in talentsList) {
        talent = UnderlordTalent.fromJson(map);
        underlordTalents.add(talent);
      }

      return UnderlordDetail(
          id: underlord.id,
          name: underlord.name,
          abilities: underlordAbilities,
          talents: underlordTalents);
    }

    return null;
  }

  Future<List<Guide>> getGuides() async {
    String query = """
      SELECT guides.*,
        group_concat(guidesDetail.id, ",") AS guidesDetailIds,
        group_concat(guidesDetail.title, ",") AS guidesDetailTitles,
        group_concat(guidesDetail.shortDescription, ",") AS guidesDetailShortDescriptions,
        group_concat(guidesDetail.thumbnail, ",") AS guidesDetailThumbnails
      FROM guides
      LEFT JOIN guidesDetail ON guides.id = guidesDetail.guideId
      GROUP BY guides.id
      ORDER BY guides.id ASC;
    """;

    List<Map> list = await _database.rawQuery(query);
    List<Guide> guides = [];
    Guide guide;
    for (var map in list) {
      guide = Guide.fromJson(convertMapGuideDetail(Map.from(map)));
      guides.add(guide);
    }
    return guides;
  }

  Map<String, dynamic> convertMapGuideDetail(Map<String, dynamic> map) {
    List<Map<String, dynamic>> guidesDetail = [];

    if (map.containsKey("guidesDetailIds") &&
        map.containsKey("guidesDetailTitles") &&
        map.containsKey("guidesDetailShortDescriptions") &&
        map.containsKey("guidesDetailThumbnails")) {
      String idsStr = map['guidesDetailIds'];
      String titlesStr = map['guidesDetailTitles'];
      String shortDescriptionsStr = map['guidesDetailShortDescriptions'];
      String thumbnailsStr = map['guidesDetailThumbnails'];

      if (idsStr != null) {
        List<String> ids = idsStr.split(",");
        List<String> titles = titlesStr.split(",");
        List<String> shortDescriptions = shortDescriptionsStr.split(",");
        List<String> thumbnails = thumbnailsStr.split(",");

        for (var i = 0; i < ids.length; i++) {
          guidesDetail.add({
            "id": int.parse(ids[i]),
            "title": titles[i],
            "shortDescription": shortDescriptions[i],
            "thumbnail": thumbnails[i],
          });
        }
      }
    }

    map['guides'] = guidesDetail;

    return map;
  }

  Future<GuideDetail> findGuideDetailById(int id) async {
    List<Map> list = await _database
        .rawQuery("SELECT * FROM guidesDetail where id = '$id' ");
    if (list.length > 0) {
      return GuideDetail.fromJson(list.first);
    }
    return null;
  }

  Future<List<Patch>> loadPatches() async {
    List<Map> list =
        await _database.rawQuery("SELECT * from patches");
    List<Patch> patches = [];
    Patch patch;
    for (var map in list) {
      patch = Patch.fromJson(map);
      patches.add(patch);
    }
    return patches;
  }
}
