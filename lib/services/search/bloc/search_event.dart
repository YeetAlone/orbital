part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

// navigation
class GotoSearchEvent extends SearchEvent {
  final SearchEnum page;
  const GotoSearchEvent({required this.page});

  @override
  List<Object> get props => [page];
}

// search action
class SearchActionEvent extends SearchEvent {
  final SearchEnum page;
  final String query;
  const SearchActionEvent({required this.page, required this.query});

  @override
  List<Object> get props => [page];
}

// add to chat
class SearchAddToChatEvent extends SearchEvent {
  final AppUserData newPerson;
  final String loggedInUserEmail;
  const SearchAddToChatEvent(
      {required this.newPerson, required this.loggedInUserEmail});
}
