import 'package:bloc/bloc.dart';
import 'package:building/services/cloud/firebase_cloud_storage.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

// makeshift error handling, need to show error to user
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    final userService = FirebaseCloudStorage();
    on<UpdateNameEvent>((event, emit) {
      try {
        userService.updateAppUser(email: event.email, fullName: event.name);
        emit(ProfileInitial(name: event.name));
      } catch (e) {
        emit(const ProfileInitial());
      }
    });
    on<UpdateDepartmentEvent>((event, emit) {
      try {
        userService.updateAppUser(
            email: event.email, department: event.department);
        emit(ProfileInitial(department: event.department));
      } catch (e) {
        // rethrow;
        emit(const ProfileInitial());
      }
    });

    on<UpdateLocationEvent>((event, emit) {
      try {
        userService.updateAppUser(email: event.email, location: event.location);
        emit(ProfileInitial(location: event.location));
      } catch (e) {
        emit(const ProfileInitial());
      }
    });
  }
}
