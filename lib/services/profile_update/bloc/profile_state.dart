part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  final String name;
  final String department;
  final String location;
  const ProfileInitial(
      {this.location = "", this.name = "", this.department = ""});

  @override
  List<Object> get props => [name, department, location];
}

class UpdateName extends ProfileState {
  const UpdateName();
}

class UpdateDepartment extends ProfileState {
  const UpdateDepartment();
}

class UpdateLocation extends ProfileState {
  const UpdateLocation();
}
