import 'package:building/services/search/bloc/search_bloc.dart';
import 'package:building/shared/search_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindByName extends StatefulWidget {
  const FindByName({Key? key}) : super(key: key);

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
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
          BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (_searchController.text.trim() != "") {
                    context.read<SearchBloc>().add(SearchActionEvent(
                        page: SearchEnum.name,
                        query: _searchController.text.trim()));
                  }
                },
                icon: const Icon(Icons.search),
              );
            },
          ),
        ],
      ),
    );
  }
}
