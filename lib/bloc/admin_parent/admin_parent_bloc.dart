import 'package:bilal/models/parent_model.dart';
import 'package:bilal/repository/admin_parents_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_parent_event.dart';
part 'admin_parent_state.dart';

class AdminParentBloc extends Bloc<AdminParentEvent, AdminParentState> {
  AdminParentsRepository adminParentsRepository = AdminParentsRepository();
  AdminParentBloc() : super(const AdminParentInitial()) {
    on<GetParents>((event, emit) async {
      if (state is AdminParentsLoading) return;
      emit(const AdminParentsLoading());
      try {
        List<Parent> parents = await adminParentsRepository.getParents();
        emit(AdminParentsLoaded(parents: parents));
      } catch (error) {
        emit(AdminParentLoadingFailed(e: error));
      }
    });

    on<CreateParent>((event, emit) async {
      try {
        if (state is AdminParentCreationLoading) return;
        emit(const AdminParentCreationLoading());
        List<dynamic> user = await adminParentsRepository.createParent(
            event.name, event.sex, event.phone, event.email, event.address);
        emit(AdminParentsCreated(parent: user));
      } catch (error) {
        emit(AdminParentCreationFailed(e: error));
      }
    });

    on<EditParent>((event, emit) async {
      try {
        await adminParentsRepository.editParent(
            parentId: event.id,
            name: event.name,
            sex: event.sex,
            phone: event.phone,
            username: event.username,
            email: event.email,
            address: event.address);
        emit(const AdminParentsLoading());
        List<Parent> parents = await adminParentsRepository.getParents();
        emit(AdminParentsLoaded(parents: parents));
      } catch (error) {
        emit(AdminParentEditingFailed(e: error));
      }
    });
  }
}
