import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuCard extends StatelessWidget {
  final String name;
  final String routeName;
  final Icon icon;
  const MenuCard(
      {super.key,
      required this.name,
      required this.routeName,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pushNamed(routeName);
      },
      child: Container(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(64, 75, 96, 0.9),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: 30.0,
              ),
            ],
          )),
    );
  }
}
