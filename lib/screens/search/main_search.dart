import 'package:building/screens/search/find_by_availability.dart';
import 'package:building/screens/search/find_by_building.dart';
import 'package:building/screens/search/find_by_name.dart';
import 'package:building/services/cloud/firebase_cloud_storage.dart';
import 'package:building/services/search/bloc/search_bloc.dart';
import 'package:building/shared/search_constants.dart';
import 'package:flutter/material.dart';
// import '../../shared/constants.dart';
import 'package:building/components/app_bar.dart';
import 'package:building/components/search_method_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainSearch extends StatelessWidget {
  /// TODO: 1. navigate the buttons to the respective pages
  /// TODO: 2. try to put different colours for the borders.

  final String userAuthId;
  const MainSearch({required this.userAuthId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // initial state
    context
        .read<SearchBloc>()
        .add(const GotoSearchEvent(page: SearchEnum.initial));

    return Scaffold(
      //body
      body: FutureBuilder<String>(
          future: FirebaseCloudStorage().getUserEmailFromId(userAuthId),
          builder: (context, snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              throw Exception();
            }
            return BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
              if (state is BuildingSearch) {
                return const FindByBuilding();
              } else if (state is AvailabilitySearch) {
                return const FindByAvailability();
              } else if (state is NameSearch) {
                return FindByName(userEmail: snapshot.data!);
              } else if (state is SearchInitial) {
                return Column(
                  children: <Widget>[
                    appBar("SEARCH"),
                    const SizedBox(height: 150),
                    const Center(
                        child: Text("How do you want to find your colleague?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromRGBO(0, 77, 64, 1)))),
                    const SizedBox(height: 50),
                    SearchMethodButton(
                        title: "   Find by Name",
                        iconURL: "assets/name.png",
                        bg: const [225, 242, 226],
                        onPressed: () => context
                            .read<SearchBloc>()
                            .add(const GotoSearchEvent(page: SearchEnum.name))),
                    const SizedBox(height: 20),
                    SearchMethodButton(
                        title: "  Find by Building",
                        iconURL: "assets/building.png",
                        bg: const [244, 250, 244],
                        onPressed: () => context.read<SearchBloc>().add(
                            const GotoSearchEvent(page: SearchEnum.building))),
                    const SizedBox(height: 20),
                    SearchMethodButton(
                        title: " Find by Availability",
                        iconURL: "assets/availability.png",
                        bg: const [255, 255, 255],
                        onPressed: () => context.read<SearchBloc>().add(
                            const GotoSearchEvent(
                                page: SearchEnum.availability))),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            });
          }),
    );
  }
}
