import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/screens/bloc/search_screen/bloc.dart';
import 'package:invest_manager/screens/company.dart';

class StockCompanySearch extends StatelessWidget {
  const StockCompanySearch({
    super.key,
  });

  Widget _buildCompaniesTiles(BuildContext context, SearchScreenState state) {
    if (state is SearchedScreenState) {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.companies.length,
          itemBuilder: (context, index) => ListTile(
            onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompanyScreen(
                      company: state.companies[index],
                    ),
                  ),
                )),
            title: Text(state.companies[index].name),
            subtitle: Text(state.companies[index].segment),
          ),
        ),
      );
    } else if (state is InitialSearchScreenState) {
      return const SizedBox(
        height: 0,
      );
    } else {
      return const Text("searching");
    }
  }

  Widget _buildScreen(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (context, state) => Column(
        children: [
          TextFormField(
            initialValue: state.search,
            onChanged: (value) => BlocProvider.of<SearchScreenBloc>(context)
                .add(NewSearchEvent(search: value)),
            decoration:
                const InputDecoration(labelText: 'Search for companies'),
          ),
          const SizedBox(height: 20),
          _buildCompaniesTiles(context, state),
        ],
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

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Stock Company'),
      ),
      body: const StockCompanySearch(),
    );
  }
}
