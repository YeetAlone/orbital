import 'package:bloc/bloc.dart';

import 'nav_event.dart';
import 'nav_state.dart';

// can improve logic and complexity later, this more or less works for now

class NavBloc extends Bloc<NavEvent, NavState> {
  // start at profile for now, change to map later
  NavBloc() : super(const NavStateMap()) {
    // go to profile
    on<NavEventGoToProfile>((event, emit) async {
      emit(const NavStateProfile());
    });

    // go to search
    on<NavEventGoToSearch>((event, emit) async {
      emit(const NavStateSearch());
    });

    // go to map - extra logic needed for map to load
    on<NavEventMapLoading>((event, emit) async {
      emit(const NavStateMapLoading());
    });

    // go to map - loaded
    on<NavEventGoToMap>((event, emit) async {
      emit(const NavStateMap());
    });

    // go to chat
    on<NavEventGoToChat>((event, emit) async {
      emit(const NavStateChat());
    });
  }
}
