part of 'admin_parent_bloc.dart';

abstract class AdminParentEvent extends Equatable {
  const AdminParentEvent();
}

class GetParents extends AdminParentEvent {
  const GetParents();

  @override
  List<Object?> get props => [];
}

class CreateParent extends AdminParentEvent {
  final String name;
  final String sex;
  final String phone;
  final String? email;
  final String address;

  const CreateParent(
      {required this.name,
      required this.sex,
      required this.phone,
      this.email,
      required this.address});

  @override
  List<String> get props => [name, sex, phone, address];
}

class DeleteParent extends AdminParentEvent {
  final String parentId;
  const DeleteParent({required this.parentId});

  @override
  List<String> get props => [parentId];
}

class EditParent extends AdminParentEvent {
  final String id;
  final String name;
  final String username;
  final String sex;
  final String phone;
  final String? email;
  final String address;

  const EditParent(
      {required this.id,
      required this.name,
      required this.username,
      required this.sex,
      required this.phone,
      required this.email,
      required this.address});

  @override
  List<String> get props => [id, name, sex, phone, address];
}
