import 'package:flutter/material.dart';

const String TIER_5_COLOR = '#FCDF85';
const String TIER_4_COLOR = '#E56DEC';
const String TIER_3_COLOR = '#5B87FF';
const String TIER_2_COLOR = '#5AFD86';
const String TIER_1_COLOR = '#CCCCCE';

const String ANESSIX_COLOR = '#f94dff';
const String HOBGEN_COLOR = '#fc7700';

const String HERO_ONE_STAR_COLOR = '#ccb592';
const String HERO_TWO_STAR_COLOR = '#d4e8fa';
const String HERO_THREE_STAR_COLOR = '#fffb11';

const ASSASSIN_COLOR = '#7b4c7d';
const BLOOD_BOUND_COLOR = '#791513';
const BRAWNY_COLOR = '#a61b1b';
const BRUTE_COLOR = '#8b7765';
const CHAMPION_COLOR = '#9a80c0';
const DEADEYE_COLOR = '#c29315';
const DEMON_COLOR = '#9e1d74';
const DRAGON_COLOR = '#ff511b';
const DRUID_COLOR = '#2e6340';
const ELUSIVE_COLOR = '#5f97d0';
const HEARLER_COLOR = '#4fd565';
const HEARTLESS_COLOR = '#7fa09a';
const HUMAN_COLOR = '#02c89c';
const HUNTER_COLOR = '#ff7652';
const INSECT_COLOR = '#4c68fc';
const INVENTOR_COLOR = '#fb8e14';
const KNIGHT_COLOR = '#ffe327';
const MAGE_COLOR = '#58dde9';
const PRIMODIAL_COLOR = '#008080';
const SAVAGE_COLOR = '#b2411a';
const SCALED_COLOR = '#483fa2';
const SCRAPPY_COLOR = '#b8c72c';
const SHAMAN_COLOR = '#6c985b';
const TROLL_COLOR = '#9e6e4a';
const WARLOCK_COLOR = '#e46ed5';
const WARRIOR_COLOR = '#1c67b4';

const ALLIANCE_BG_COLOR = '#181a31';

const LINK_COLOR = '#007bff';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color getColorByTier(String tier) {
  switch (tier) {
    case 'Tier 1':
    case 'Tier One':
      return HexColor(TIER_1_COLOR);
    case 'Tier 2':
    case 'Tier Two':
      return HexColor(TIER_2_COLOR);
    case 'Tier 3':
    case 'Tier Three':
      return HexColor(TIER_3_COLOR);
    case 'Tier 4':
    case 'Tier Four':
      return HexColor(TIER_4_COLOR);
    case 'Tier 5':
    case 'Tier Five':
      return HexColor(TIER_5_COLOR);
    case 'Ace':
      return HexColor(TIER_5_COLOR);
    default:
      return HexColor(TIER_1_COLOR);
  }
}

Color getUnderlordColor(String name) {
  switch (name.toUpperCase()) {
    case 'ANESSIX':
      return HexColor(ANESSIX_COLOR);
    case 'HOBGEN':
      return HexColor(HOBGEN_COLOR);
    default:
      return Colors.white;
  }
}

Color getColorByAlliance(String alliance) {
  String colorStr;

  switch (alliance) {
    case 'Assassin':
      colorStr = ASSASSIN_COLOR;
      break;
    case 'Blood-bound':
      colorStr = BLOOD_BOUND_COLOR;
      break;
    case 'Blood-Bound':
      colorStr = BLOOD_BOUND_COLOR;
      break;
    case 'Brawny':
      colorStr = BRAWNY_COLOR;
      break;
    case 'Deadeye':
      colorStr = DEADEYE_COLOR;
      break;
    case 'Demon':
      colorStr = DEMON_COLOR;
      break;
    case 'Dragon':
      colorStr = DRAGON_COLOR;
      break;
    case 'Druid':
      colorStr = DRUID_COLOR;
      break;
    case 'Elusive':
      colorStr = ELUSIVE_COLOR;
      break;
    case 'Heartless':
      colorStr = HEARTLESS_COLOR;
      break;
    case 'Human':
      colorStr = HUMAN_COLOR;
      break;
    case 'Hunter':
      colorStr = HUNTER_COLOR;
      break;
    case 'Inventor':
      colorStr = INVENTOR_COLOR;
      break;
    case 'Knight':
      colorStr = KNIGHT_COLOR;
      break;
    case 'Mage':
      colorStr = MAGE_COLOR;
      break;
    case 'Primordial':
      colorStr = PRIMODIAL_COLOR;
      break;
    case 'Savage':
      colorStr = SAVAGE_COLOR;
      break;
    case 'Scaled':
      colorStr = SCALED_COLOR;
      break;
    case 'Scrappy':
      colorStr = SCRAPPY_COLOR;
      break;
    case 'Shaman':
      colorStr = SHAMAN_COLOR;
      break;
    case 'Troll':
      colorStr = TROLL_COLOR;
      break;
    case 'Warlocks':
      colorStr = WARLOCK_COLOR;
      break;
    case 'Warrior':
      colorStr = WARRIOR_COLOR;
      break;
    case 'Brute':
      colorStr = BRUTE_COLOR;
      break;
    case 'Healer':
      colorStr = HEARLER_COLOR;
      break;
    case 'Insect':
      colorStr = INSECT_COLOR;
      break;
    case 'Champion':
      colorStr = CHAMPION_COLOR;
      break;
  }
  return HexColor(colorStr);
}
