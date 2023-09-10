import 'package:app/app/routes.dart';
import 'package:app/shared/entities/user.dart';
import 'package:app/ui/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchLoaded extends StatelessWidget {
  const SearchLoaded({
    super.key,
    required this.users,
    required this.hasReachedMax,
    required this.onLoadingMore,
  });

  final List<User> users;
  final bool hasReachedMax;
  final VoidCallback onLoadingMore;

  @override
  Widget build(BuildContext context) {
    return users.isEmpty //
        ? const SearchLoadedEmpty()
        : SearchLoadedList(
            users: users,
            hasReachedMax: hasReachedMax,
            onLoadingMore: onLoadingMore,
          );
  }
}

class SearchLoadedList extends StatelessWidget {
  const SearchLoadedList({
    super.key,
    required this.users,
    required this.hasReachedMax,
    required this.onLoadingMore,
  });

  final List<User> users;
  final bool hasReachedMax;
  final VoidCallback onLoadingMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!hasReachedMax && notification.metrics.extentAfter < 100) {
          onLoadingMore();
        }
        return false;
      },
      child: ListView.separated(
        itemCount: hasReachedMax ? users.length : users.length + 1,
        itemBuilder: (context, index) {
          if (index == users.length) {
            return const ActivityIndicator();
          }
          return ListTile(
            title: users[index].name.isNotEmpty //
                ? Text(users[index].name)
                : Text(users[index].login),
            subtitle: users[index].login.isNotEmpty && //
                    users[index].name.isNotEmpty
                ? Text(users[index].login)
                : null,
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundImage: CachedNetworkImageProvider(users[index].avatarUrl),
            ),
            onTap: () => UserPageRoute(login: users[index].login).push(context),
          );
        },
        separatorBuilder: (context, index) => const ListSeparator(
          indent: 72,
        ),
      ),
    );
  }
}

class SearchLoadedEmpty extends StatelessWidget {
  const SearchLoadedEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No users found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Try searching for something else',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
