import 'package:building/screens/search/find_by_availability.dart';
import 'package:building/screens/search/find_by_building.dart';
import 'package:building/screens/search/find_by_name.dart';
import 'package:building/screens/search/widgets.dart';
import 'package:building/services/cloud/firebase_cloud_storage.dart';
import 'package:building/services/search/bloc/search_bloc.dart';
import 'package:building/shared/search_constants.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:building/components/app_bar.dart';
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
            if (snapshot.hasError) {
              devtools.log(snapshot.error.toString());
            }
            final userEmail = snapshot.data ?? "test@nus.edu";
            return BlocBuilder<SearchBloc, SearchState>(
                buildWhen: ((previous, current) => current is! SearchComplete),
                builder: (context, state) {
                  if (state is BuildingSearch) {
                    return const FindByBuilding();
                  } else if (state is AvailabilitySearch) {
                    return FindByAvailability(
                      userEmail: userEmail,
                    );
                  } else if (state is NameSearch) {
                    return FindByName(userEmail: userEmail);
                  } else {
                    return Column(
                      children: <Widget>[
                        screenAppBar("SEARCH"),
                        const SizedBox(height: 150),
                        const Center(
                            child: Text(
                                "How do you want to find your colleague?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromRGBO(0, 77, 64, 1)))),
                        const SizedBox(height: 50),
                        SearchMethodButton(
                            title: "   Find by Name",
                            iconURL: "assets/name.png",
                            bg: const [225, 242, 226],
                            onPressed: () => context.read<SearchBloc>().add(
                                const GotoSearchEvent(page: SearchEnum.name))),
                        const SizedBox(height: 20),
                        SearchMethodButton(
                            title: "  Find by Building",
                            iconURL: "assets/building.png",
                            bg: const [244, 250, 244],
                            onPressed: () => context.read<SearchBloc>().add(
                                const GotoSearchEvent(
                                    page: SearchEnum.building))),
                        const SizedBox(height: 20),
                        SearchMethodButton(
                            title: " Find by Availability",
                            iconURL: "assets/availability.png",
                            bg: const [255, 255, 255],
                            onPressed: () {
                              context.read<SearchBloc>().add(
                                  const GotoSearchEvent(
                                      page: SearchEnum.availability));
                              devtools.log("Find by availability pressed");
                            }),
                      ],
                    );
                  }
                });
          }),
    );
  }
}
