part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

// initial state when the user lands on the search page
class SearchInitial extends SearchState {
  const SearchInitial();
}

// search by building
class BuildingSearch extends SearchState {
  const BuildingSearch();
}

// search by availability
class AvailabilitySearch extends SearchState {
  const AvailabilitySearch();
}

// search by name
class NameSearch extends SearchState {
  const NameSearch();
}

class SearchComplete extends SearchState {
  final Stream<Iterable<AppUserData>> results;
  const SearchComplete({required this.results});
}
