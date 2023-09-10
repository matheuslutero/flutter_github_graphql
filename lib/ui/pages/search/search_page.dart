import 'package:app/shared/config/deps.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:app/ui/pages/search/bloc/search_bloc.dart';
import 'package:app/ui/pages/search/widgets/search_failure.dart';
import 'package:app/ui/pages/search/widgets/search_initial.dart';
import 'package:app/ui/pages/search/widgets/search_loaded.dart';
import 'package:app/ui/pages/search/widgets/search_loading.dart';
import 'package:app/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        UserRepository(locator.get()),
      ),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            flexibleSpace: SafeArea(
              child: SearchTextField(
                onClear: () => context.read<SearchBloc>().add(SearchEventClear()),
                onSubmitted: (value) => context.read<SearchBloc>().add(SearchEventFetch(value)),
              ),
            ),
          ),
          body: Builder(
            builder: (context) {
              switch (state.status) {
                case SearchStatus.initial:
                  return const SearchInitial();
                case SearchStatus.loading:
                  return const SearchLoading();
                case SearchStatus.loaded:
                  return SearchLoaded(
                    users: state.users,
                    hasReachedMax: state.hasReachedMax,
                    onLoadingMore: () => context.read<SearchBloc>().add(SearchEventLoadMore()),
                  );
                case SearchStatus.failure:
                  return const SearchFailure();
              }
            },
          ),
        ),
      ),
    );
  }
}
