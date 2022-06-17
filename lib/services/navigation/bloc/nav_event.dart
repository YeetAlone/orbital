import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NavEvent {
  const NavEvent();
}

class NavEventGoToMap extends NavEvent {
  const NavEventGoToMap();
}

class NavEventGoToProfile extends NavEvent {
  const NavEventGoToProfile();
}

class NavEventGoToSearch extends NavEvent {
  const NavEventGoToSearch();
}

class NavEventMapLoading extends NavEvent {
  const NavEventMapLoading();
}

class NavEventGoToChat extends NavEvent {
  const NavEventGoToChat();
}
