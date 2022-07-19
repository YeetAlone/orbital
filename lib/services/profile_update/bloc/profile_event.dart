part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateNameEvent extends ProfileEvent {
  final String name;
  final String email;

  const UpdateNameEvent(this.name, this.email);

  @override
  List<Object> get props => [name];
}

class UpdateDepartmentEvent extends ProfileEvent {
  final String department;
  final String email;

  const UpdateDepartmentEvent(this.department, this.email);

  @override
  List<Object> get props => [department];
}
