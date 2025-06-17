import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';
import '../widgets/user_card.dart';
import 'user_detail_page.dart';

class UserListPage extends StatefulWidget {
  final GetUsers getUsers;

  const UserListPage({
    super.key,
    required this.getUsers,
  });

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final result = await widget.getUsers(GetUsersParams(page: pageKey));

      result.fold(
        (failure) {
          _pagingController.error = failure.toString();
        },
        (response) {
          final isLastPage = pageKey >= response.totalPages;
          final users = response.data
              .map((user) => User(
                    id: user.id,
                    email: user.email,
                    firstName: user.firstName,
                    lastName: user.lastName,
                    avatar: user.avatar,
                  ))
              .toList();

          if (isLastPage) {
            _pagingController.appendLastPage(users);
          } else {
            _pagingController.appendPage(users, pageKey + 1);
          }
        },
      );
    } catch (e) {
      _pagingController.error = e.toString();
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: PagedListView<int, User>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<User>(
            itemBuilder: (context, user, index) => UserCard(
              user: user,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailPage(userId: user.id),
                ),
              ),
            ),
            firstPageProgressIndicatorBuilder: (_) =>
                const Center(child: CircularProgressIndicator()),
            newPageProgressIndicatorBuilder: (_) =>
                const Center(child: CircularProgressIndicator()),
            noItemsFoundIndicatorBuilder: (_) => const Center(
              child: Text('No users found'),
            ),
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_pagingController.error?.toString() ??
                      'An error occurred'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _pagingController.retryLastFailedRequest(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
