import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../entities/user.dart';
import '../state/user_list_state.dart';
import '../utils/title.dart';
import 'user_registration_screen.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  static const routeName = '/user_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => UserListState(),
        child: Consumer<UserListState>(
          builder: (context, state, child) {
            return state.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _UserListStructure(state);
          },
        ),
      ),
    );
  }
}

class _UserListStructure extends StatelessWidget {
  const _UserListStructure(this.state);

  final UserListState state;

  @override
  Widget build(BuildContext context) {
    final userList = state.userList.reversed.toList();

    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppTitle(
              title: "Here's all the associates:",
            ),
            ListView.builder(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 56,
              ),
              shrinkWrap: true,
              itemCount: userList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _UserListTile(
                user: userList[index],
                state: state,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserListTile extends StatelessWidget {
  const _UserListTile({
    required this.user,
    required this.state,
  });

  final User user;
  final UserListState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory:
          user.isActive ? InkSplash.splashFactory : NoSplash.splashFactory,
      onTap: () async {
        if (!user.isActive) {
          return;
        } else {
          await Navigator.of(context)
              .pushNamed(
                UserRegisterScreen.routeName,
                arguments: user,
              )
              .whenComplete(state.init);
        }
      },
      child: ListTile(
        enabled: user.isActive,
        title: Text(
          user.fullName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          state.roleList
              .singleWhere((element) => element.id == user.roleId)
              .roleName,
          style: const TextStyle(
            color: accentColor,
          ),
        ),
        trailing: Text(
          state.dealershipList
              .singleWhere((element) => element.id == user.dealershipId)
              .name,
        ),
      ),
    );
  }
}
