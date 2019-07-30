import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_by_tier.dart';
import 'package:UnderlordsGuru/app/model/pojo/item.dart';
import 'package:UnderlordsGuru/app/model/pojo/item_by_tier.dart';

List<HeroByTier> groupHeroesByTier(List<HeroModel> heroes) {
  List<HeroByTier> results = [];
  results.add(HeroByTier.isHeader(header: 'Tier 1'));
  results.add(HeroByTier.isHeader(header: 'Tier 2'));
  results.add(HeroByTier.isHeader(header: 'Tier 3'));
  results.add(HeroByTier.isHeader(header: 'Tier 4'));
  results.add(HeroByTier.isHeader(header: 'Ace'));
  int tier1 = 1, tier2 = 1, tier3 = 1, tier4 = 1, tier5 = 1;

  heroes.forEach((HeroModel hero) {
    if (hero.tier.trim() == 'Tier One') {
      results.insert(tier1, HeroByTier.isHero(hero: hero));
      tier1++;
    } else if (hero.tier.trim() == 'Tier Two') {
      results.insert(tier1 + tier2, HeroByTier.isHero(hero: hero));
      tier2++;
    } else if (hero.tier.trim() == 'Tier Three') {
      results.insert(tier1 + tier2 + tier3, HeroByTier.isHero(hero: hero));
      tier3++;
    } else if (hero.tier.trim() == 'Tier Four') {
      results.insert(
          tier1 + tier2 + tier3 + tier4, HeroByTier.isHero(hero: hero));
      tier4++;
    } else if (hero.tier.trim() == 'Ace') {
      results.insert(
          tier1 + tier2 + tier3 + tier4 + tier5, HeroByTier.isHero(hero: hero));
      tier5++;
    }
  });

  return results;
}

List<ItemByTier> groupItemsByTier(List<Item> items, bool isItem) {
  List<ItemByTier> results = [];
  results.add(ItemByTier.isHeader(header: 'Tier 1'));
  results.add(ItemByTier.isHeader(header: 'Tier 2'));
  results.add(ItemByTier.isHeader(header: 'Tier 3'));
  results.add(ItemByTier.isHeader(header: 'Tier 4'));
  results.add(ItemByTier.isHeader(header: isItem ? 'Tier 5' : 'Ace'));
  int tier1 = 1, tier2 = 1, tier3 = 1, tier4 = 1, tier5 = 1;

  items.forEach((Item item) {
    if (item.tier.trim() == 'Tier One') {
      results.insert(tier1, ItemByTier.isItem(item: item));
      tier1++;
    } else if (item.tier.trim() == 'Tier Two') {
      results.insert(tier1 + tier2, ItemByTier.isItem(item: item));
      tier2++;
    } else if (item.tier.trim() == 'Tier Three') {
      results.insert(tier1 + tier2 + tier3, ItemByTier.isItem(item: item));
      tier3++;
    } else if (item.tier.trim() == 'Tier Four') {
      results.insert(
          tier1 + tier2 + tier3 + tier4, ItemByTier.isItem(item: item));
      tier4++;
    } else if (item.tier.trim() == 'Ace' || item.tier.trim() == 'Tier Five') {
      results.insert(
          tier1 + tier2 + tier3 + tier4 + tier5, ItemByTier.isItem(item: item));
      tier5++;
    }
  });

  return results;
}
