import 'package:bloc/bloc.dart';
import 'package:building/services/cloud/firebase_cloud_storage.dart';
import 'package:building/shared/shared_data.dart';
import 'dart:developer' as devtools show log;
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
        emit(ProfileInitial(
            name: event.name, department: SharedPrefs.userDepartment));
      } catch (e) {
        devtools.log(e.toString());
        emit(const ProfileInitial());
      }
    });
    on<UpdateDepartmentEvent>((event, emit) {
      try {
        userService.updateAppUser(
            email: event.email, department: event.department);
        emit(ProfileInitial(
            name: SharedPrefs.userFullName, department: event.department));
      } catch (e) {
        // rethrow;
        devtools.log(e.toString());
        emit(const ProfileInitial());
      }
    });
  }
}
