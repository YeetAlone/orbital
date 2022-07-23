import 'package:building/shared/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:building/components/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';

// import 'dart:developer' as devtools show log;

import '../../services/search/bloc/search_bloc.dart';
import '../../shared/search_constants.dart';

class FindByBuilding extends StatefulWidget {
  const FindByBuilding({Key? key}) : super(key: key);

  @override
  State<FindByBuilding> createState() => _FindByBuildingState();
}

class _FindByBuildingState extends State<FindByBuilding> {
  late final TextEditingController _search;

  @override
  void initState() {
    _search = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          screenAppBar("FIND BY BUILDING"),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _search,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    if (_search.text.trim() != "") {
                      context.read<SearchBloc>().add(SearchActionEvent(
                          page: SearchEnum.building,
                          query: _search.text.trim()));
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              final userEmail = SharedPrefs.userEmail;
              if (state is SearchComplete) {
                return StreamBuilder<Iterable<AppUserData>>(
                    stream: state.results,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Text('done');
                      } else if (snapshot.hasError) {
                        return const Text('Error!');
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Text("No results");
                      } else {
                        return SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data!.elementAt(index).email ==
                                  userEmail) {
                                if (snapshot.data!.length == 1) {
                                  return const Text("No results");
                                }
                                return Container();
                              }
                              return ListTile(
                                title: Text(
                                    snapshot.data!.elementAt(index).userName),
                                onTap: () {},
                              );
                            },
                          ),
                        );
                      }
                    }));
              } else if (state is BuildingSearch) {
                return Container();
              } else {
                return const Text("OH THERE'S A PROBLEM ALRIGHT");
              }
            },
          ),
        ],
      ),
    );
  }
}
