import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_view_model.dart';
import 'user_repository.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(UserRepository())..loadUserName(),
      child: Scaffold(
        appBar: AppBar(title: Text('User Info')),
        body: Consumer<UserViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Center(child: Text('Hello, ${viewModel.userName ?? "Guest"}'));
          },
        ),
      ),
    );
  }
}
