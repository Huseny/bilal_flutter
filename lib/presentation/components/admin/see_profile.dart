import 'package:flutter/material.dart';

class SeeProfile extends StatelessWidget {
  final Map<String, String> fields;
  const SeeProfile({super.key, required this.fields});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fields["اسم"]!),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "معلومات شخصية",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  ...fields.entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(children: [
                              Text('${e.key}:'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                e.value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("عرض كلمة المرور"))
        ],
      ),
    );
  }
}
