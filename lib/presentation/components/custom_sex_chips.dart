import 'package:flutter/material.dart';

class CustomSexChips extends StatefulWidget {
  const CustomSexChips({super.key, required this.onSelected});

  final void Function(int) onSelected;

  @override
  State<CustomSexChips> createState() => _CustomSexChipsState();
}

class _CustomSexChipsState extends State<CustomSexChips> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          const Text("الجنس: "),
          const SizedBox(
            width: 40,
          ),
          ChoiceChip(
            label: const Text("ذكر"),
            selected: selectedIndex == 0,
            onSelected: (value) {
              setState(() {
                widget.onSelected(value ? 0 : -1);
                selectedIndex = value ? 0 : -1;
              });
            },
          ),
          const SizedBox(width: 40),
          ChoiceChip(
            label: const Text("أنثى"),
            selected: selectedIndex == 1,
            onSelected: (value) {
              setState(() {
                widget.onSelected(value ? 1 : -1);
                selectedIndex = value ? 1 : -1;
              });
            },
          ),
        ],
      ),
    );
  }
}
