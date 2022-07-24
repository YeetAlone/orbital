import 'package:bloc/bloc.dart';
import 'package:building/models/user.dart';
import 'package:building/services/cloud/firebase_cloud_storage.dart';
import 'package:building/shared/search_constants.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchInitial()) {
    on<GotoSearchEvent>((event, emit) {
      switch (event.page) {
        case SearchEnum.initial:
          emit(const SearchInitial());
          break;
        case SearchEnum.building:
          emit(const BuildingSearch());
          break;
        case SearchEnum.availability:
          emit(const AvailabilitySearch());
          break;
        case SearchEnum.name:
          emit(const NameSearch());
          break;
      }
    });
    on<SearchActionEvent>((event, emit) {
      final db = FirebaseCloudStorage();
      switch (event.page) {
        case SearchEnum.initial:
          // There should be no initial search action at initialization
          throw Exception(
              "There should be no initial search action at initialization");
        case SearchEnum.building:
          emit(SearchComplete(results: db.findUsersByBuilding(event.query)));
          break;
        case SearchEnum.availability:
          emit(
              SearchComplete(results: db.findUsersByAvailability(event.query)));
          break;
        case SearchEnum.name:
          // print(event.query.toLowerCase().trim());
          emit(SearchComplete(
              results: db.findUsersByName(event.query.toLowerCase().trim())));
          break;
      }
    });

    on<SearchAddToChatEvent>((event, emit) {
      // FirebaseChatStorage().createChatUser(
      //     sender: event.newPerson, receiverEmail: event.loggedInUserEmail);
      // TODO: emit an exit event
    });
  }
}
