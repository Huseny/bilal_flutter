import 'package:bilal/models/abstracts/lsited_people.dart';
import 'package:flutter/material.dart';

class Parent implements ListedPerson {
  Parent(
      this.name, this.username, this.sex, this.phone, this.email, this.address,
      {this.id});

  final String? id;
  final String name;
  final String username;
  final String sex;
  final String phone;
  final String email;
  final String address;

  bool selected = false;

  factory Parent.fromFirestore(
    Map<String, dynamic> data,
  ) {
    return Parent(
        id: data["uid"],
        data['name'],
        data["username"],
        data["sex"],
        data["phone"],
        data["email"],
        data["address"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "sex": sex,
      "phone": phone,
      "email": email,
      "address": address
    };
  }

  @override
  List<DataCell> getCells() {
    return [
      DataCell(IconButton(
        icon: const Icon(
          Icons.edit_rounded,
          size: 10,
        ),
        onPressed: () {
          // ignore: avoid_print
          print(id);
        },
      )),
      DataCell(Text(name)),
      DataCell(Text(username)),
      DataCell(Text(sex)),
      DataCell(Text(phone)),
      DataCell(Text(email)),
      DataCell(Text(address)),
    ];
  }
}
