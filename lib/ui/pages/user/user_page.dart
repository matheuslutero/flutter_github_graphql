import 'package:app/shared/config/deps.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:app/ui/pages/user/bloc/user_bloc.dart';
import 'package:app/ui/pages/user/widgets/user_page_failure.dart';
import 'package:app/ui/pages/user/widgets/user_page_loaded.dart';
import 'package:app/ui/pages/user/widgets/user_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({
    super.key,
    required this.login,
  });

  final String login;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(locator.get()),
      )..add(UserEventFetch(login)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => switch (state) {
          UserStateLoading() => const UserPageLoading(),
          UserStateLoaded() => UserPageLoaded(user: state.user),
          UserStateFailure() => UserPageFailure(
              onReload: () => context.read<UserBloc>().add(UserEventFetch(login)),
            ),
        },
      ),
    );
  }
}
