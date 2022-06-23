import 'package:building/components/app_bar.dart';
import 'package:building/models/user.dart';
import 'package:building/services/search/bloc/search_bloc.dart';
import 'package:building/shared/search_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindByName extends StatefulWidget {
  final String userEmail;
  const FindByName({required this.userEmail, Key? key}) : super(key: key);

  @override
  State<FindByName> createState() => _FindByNameState();
}

class _FindByNameState extends State<FindByName> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          appBar("FIND BY NAME"),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _searchController,
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
                    if (_searchController.text.trim() != "") {
                      context.read<SearchBloc>().add(SearchActionEvent(
                          page: SearchEnum.name,
                          query: _searchController.text.trim()));
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchComplete) {
                    return StreamBuilder<Iterable<AppUserData>>(
                        builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return const Text('done');
                      } else if (snapshot.hasError) {
                        return const Text('Error!');
                      } else {
                        return SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data!.elementAt(index).email ==
                                  widget.userEmail) {
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
                  } else if (state is NameSearch) {
                    return Container();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
