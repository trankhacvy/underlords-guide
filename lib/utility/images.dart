class ImageHelper {
  static String getAllianceIconByName(String name) {
    switch (name) {
      case 'Assassin':
        return 'images/alliances_assassin.png';
      case 'Blood-bound':
        return 'images/alliances_blood_bound.png';
      case 'Blood-Bound':
        return 'images/alliances_blood_bound.png';
      case 'Brawny':
        return 'images/alliances_brawny.png';
      case 'Deadeye':
        return 'images/alliances_deadeye.png';
      case 'Demon':
        return 'images/alliances_demon.png';
      case 'Demon Hunter':
        return 'images/alliances_demon_hunter.png';
      case 'Dragon':
        return 'images/alliances_dragon.png';
      case 'Druid':
        return 'images/alliances_druid.png';
      case 'Elusive':
        return 'images/alliances_elusive.png';
      case 'Heartless':
        return 'images/alliances_heartless.png';
      case 'Human':
        return 'images/alliances_human.png';
      case 'Hunter':
        return 'images/alliances_hunter.png';
      case 'Inventor':
        return 'images/alliances_inventor.png';
      case 'Knight':
        return 'images/alliances_knight.png';
      case 'Mage':
        return 'images/alliances_mage.png';
      case 'Primordial':
        return 'images/alliances_primordial.png';
      case 'Savage':
        return 'images/alliances_savage.png';
      case 'Scaled':
        return 'images/alliances_scaled.png';
      case 'Scrappy':
        return 'images/alliances_scrappy.png';
      case 'Shaman':
        return 'images/alliances_shaman.png';
      case 'Troll':
        return 'images/alliances_troll.png';
      case 'Warlocks':
        return 'images/alliances_warlocks.png';
      case 'Warrior':
        return 'images/alliances_warrior.png';
      case 'Brute':
        return 'images/alliances_brute.png';
      case 'Healer':
        return 'images/alliances_healer.png';
      case 'Insect':
        return 'images/alliances_insect.png';
      case 'Champion':
        return 'images/alliances_champion.png';

      default:
        print('icon not found $name');
        throw Exception('Icon not found');
    }
  }

  static String getTierBanner(String tier) {
    switch (tier) {
      case 'Tier 1':
        return 'images/hero_tier1.png';
      case 'Tier 2':
        return 'images/hero_tier2.png';
      case 'Tier 3':
        return 'images/hero_tier3.png';
      case 'Tier 4':
        return 'images/hero_tier4.png';
      default:
        return 'images/hero_tier_ace.png';
    }
  }

  static String getItemTypeIcon(String type) {
    switch (type) {
      case 'Global':
        return 'images/ic_global_item.png';
      case 'Defensive':
        return 'images/ic_defensive_item.png';
      case 'Support':
        return 'images/ic_support_item.png';
      case 'Offensive':
        return 'images/ic_offensive_item.png';
      case 'Contraption':
        return 'ic_contraption_item.png';
      default:
        return 'images/ic_global_item.png';
    }
  }
}
