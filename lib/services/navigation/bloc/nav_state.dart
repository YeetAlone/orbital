part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final NavBarItem navbarItem;
  final int index;

  const NavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}

// @immutable
// abstract class NavState {
//   const NavState();
// }

// // go to map
// class NavStateMap extends NavState {
//   const NavStateMap();
// }

// // Wait for map to load
// class NavStateMapLoading extends NavState {
//   const NavStateMapLoading();
// }

// // go to profile page
// class NavStateProfile extends NavState {
//   const NavStateProfile();
// }

// // go to search page
// class NavStateSearch extends NavState {
//   const NavStateSearch();
// }

// // go to chat page
// class NavStateChat extends NavState {
//   const NavStateChat();
// }
