import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/components/b3.dart';
import 'package:invest_manager/screens/bloc/search_screen/bloc.dart';

import '../models/b3.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
    required this.title,
  }) ;

  final String title;

  List<Widget> _buildCompaniesTiles(
      BuildContext context, SearchScreenState state) {
    if (state is SearchedScreenState) {
      return state.companies
          .map((e) => ListTile(
                title: Text(e.name),
                subtitle: Text(e.segment),
              ))
          .toList();
    } else if (state is InitialSearchScreenState) {
      return [];
    } else {
      return [const Text("searching")];
    }
  }

  Widget _buildScreen(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
              initialValue: state.search,
                onChanged: (value) => BlocProvider.of<SearchScreenBloc>(context)
                .add(NewSearchEvent(search: value)),
                decoration: const InputDecoration(labelText: 'Search for companies'),
              ),
              const SizedBox(height: 20),
               ..._buildCompaniesTiles(context, state),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchScreenBloc(),
      child: _buildScreen(context),
    );
  }
}
