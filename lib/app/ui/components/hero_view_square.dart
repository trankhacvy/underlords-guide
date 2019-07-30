// import 'package:flutter/material.dart';
// import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
// import 'package:fluro/fluro.dart';
// import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
// import 'package:UnderlordsGuru/app/ui/page/hero_detail/hero_detail_page.dart';
// import 'package:UnderlordsGuru/utility/images.dart';

// class HeroViewSquare extends StatelessWidget {
//   final HeroModel hero;

//   HeroViewSquare({Key key, this.hero}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: InkWell(
//         onTap: () {
//           print('click on hero ${hero.name}');
//           // AppProvider.getRouter(context).navigateTo(
//           //     context,
//           //     HeroDetailPage.generatePath(
//           //         hero.id.toString(), hero.name, hero.avatar, hero.alliances),
//           //     transition: TransitionType.fadeIn);
//         },
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Image.network(hero.avatar),
//             SizedBox(height: 8.0),
//             Text(hero.name),
//           ],
//         ),
//       ),
//     );
//   }
// }
