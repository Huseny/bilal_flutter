part of 'admin_parent_bloc.dart';

abstract class AdminParentState extends Equatable {
  const AdminParentState();
}

class AdminParentInitial extends AdminParentState {
  const AdminParentInitial();

  @override
  List<Object> get props => [];
}

class AdminParentsLoading extends AdminParentState {
  const AdminParentsLoading();

  @override
  List<Object?> get props => [];
}

class AdminParentsLoaded extends AdminParentState {
  final List<Parent> parents;

  const AdminParentsLoaded({required this.parents});
  @override
  List<Parent> get props => parents;
}

class AdminParentLoadingFailed extends AdminParentState {
  final Object e;
  const AdminParentLoadingFailed({required this.e});

  @override
  List<Object?> get props => [e];
}

class AdminParentsCreated extends AdminParentState {
  final FrontendUser parent;
  const AdminParentsCreated({required this.parent});

  @override
  List<FrontendUser> get props => [parent];
}

class AdminParentCreationLoading extends AdminParentState {
  const AdminParentCreationLoading();

  @override
  List<Object?> get props => [];
}

class AdminParentCreationFailed extends AdminParentState {
  final Object e;
  const AdminParentCreationFailed({required this.e});

  @override
  List<Object?> get props => [e];
}

class AdminParentEditLoading extends AdminParentState {
  const AdminParentEditLoading();
  @override
  List<Object?> get props => [];
}

class AdminParentsEdited extends AdminParentState {
  final List<Parent> parents;

  const AdminParentsEdited({required this.parents});
  @override
  List<Parent> get props => parents;
}

class AdminParentEditingFailed extends AdminParentState {
  final Object e;
  const AdminParentEditingFailed({required this.e});

  @override
  List<Object?> get props => [e];
}
