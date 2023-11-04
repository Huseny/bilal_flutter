import 'package:bilal/presentation/components/custom_app_bar.dart';
import 'package:bilal/presentation/components/menu_card.dart';
import 'package:bilal/utils/homepage_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final tabsList = HomepagesList.getList("admin");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBar(
          title: "مرحبا",
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemCount: tabsList.length,
            itemBuilder: (BuildContext context, int index) {
              return MenuCard(
                name: tabsList[index][0],
                icon: tabsList[index][1],
                routeName: tabsList[index][2],
              );
            }));
  }
}
