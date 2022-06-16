import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NavState {
  const NavState();
}

// go to map
class NavStateMap extends NavState {
  const NavStateMap();
}

// Wait for map to load
class NavStateMapLoading extends NavState {
  const NavStateMapLoading();
}

// go to profile page
class NavStateProfile extends NavState {
  const NavStateProfile();
}

// go to search page
class NavStateSearch extends NavState {
  const NavStateSearch();
}

// go to chat page
class NavStateChat extends NavState {
  const NavStateChat();
}
