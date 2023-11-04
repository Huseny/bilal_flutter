import 'package:equatable/equatable.dart';

class CustomUser extends Equatable {
  const CustomUser({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  final String id;
  final String? email;
  final String? name;
  final String? photo;

  static const empty = CustomUser(id: '');

  bool get isEmpty => this == CustomUser.empty;
  bool get isNotEmpty => this != CustomUser.empty;

  @override
  List<Object?> get props => [id, email, name, photo];
}
