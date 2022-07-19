part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  final String name;
  final String department;
  const ProfileInitial({this.name = "", this.department = ""});

  @override
  List<Object> get props => [name, department];
}

class UpdateName extends ProfileState {
  const UpdateName();
}

class UpdateDepartment extends ProfileState {
  const UpdateDepartment();
}
