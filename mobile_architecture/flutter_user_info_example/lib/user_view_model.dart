
import 'package:flutter/material.dart';
import 'user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository repository;
  String? _userName;
  bool _isLoading = false;

  UserViewModel(this.repository);

  String? get userName => _userName;
  bool get isLoading => _isLoading;

  Future<void> loadUserName() async {
    _isLoading = true;
    notifyListeners();

    _userName = await repository.fetchUserName();

    _isLoading = false;
    notifyListeners();
  }
}
