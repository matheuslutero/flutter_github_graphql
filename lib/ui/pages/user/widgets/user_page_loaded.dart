import 'package:app/shared/entities/repository.dart';
import 'package:app/shared/entities/user.dart';
import 'package:app/ui/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserPageLoaded extends StatelessWidget {
  const UserPageLoaded({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverStretchyHeader(
            title: Text(
              user.name.isNotEmpty ? user.name : user.login,
            ),
            background: CachedNetworkImage(
              imageUrl: user.avatarUrl,
              fit: BoxFit.cover,
            ),
            expandedWidget: UserPageLoadedHeader(
              user: user,
            ),
          ),
          SliverSafeArea(
            top: false,
            bottom: false,
            minimum: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Top Repositories',
                style: textTheme.titleLarge,
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            left: false,
            right: false,
            sliver: SliverList.separated(
              itemCount: user.repositories.length,
              itemBuilder: (context, index) => UserPageLoadedRepository(
                repository: user.repositories[index],
              ),
              separatorBuilder: (context, index) => const ListSeparator(),
            ),
          ),
        ],
      ),
    );
  }
}

class UserPageLoadedHeader extends StatelessWidget {
  const UserPageLoadedHeader({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user.name.isNotEmpty ? user.name : user.login,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
            ),
      ),
      subtitle: user.login.isNotEmpty && user.name.isNotEmpty
          ? Text(
              user.login,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
            )
          : null,
    );
  }
}

class UserPageLoadedRepository extends StatelessWidget {
  const UserPageLoadedRepository({
    super.key,
    required this.repository,
  });

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      title: Text(repository.name),
      subtitle: repository.description.isNotEmpty
          ? Text(repository.description) //
          : null,
    );
  }
}
