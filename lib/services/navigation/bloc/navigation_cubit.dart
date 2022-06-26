import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../shared/nav_bar_constants.dart';

part 'nav_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavBarItem.profile, 0));

  void getNavBarItem(NavBarItem navbarItem) {
    switch (navbarItem) {
      case NavBarItem.profile:
        emit(const NavigationState(NavBarItem.profile, 0));
        break;
      case NavBarItem.search:
        emit(const NavigationState(NavBarItem.search, 1));
        break;
      case NavBarItem.map:
        emit(const NavigationState(NavBarItem.map, 2));
        break;
      case NavBarItem.chat:
        emit(const NavigationState(NavBarItem.chat, 3));
        break;
    }
  }
}
