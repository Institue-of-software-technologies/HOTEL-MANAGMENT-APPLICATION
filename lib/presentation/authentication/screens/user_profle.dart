class UserProfile {
  bool _loggedIn = false;
  bool _isProfileModified = false;

  bool get isLoggedIn => _loggedIn;
  bool get isProfileModified => _isProfileModified;

  void login() {
    // Simulate login process
    _loggedIn = true;
  }

  void modifyProfile() {
    // Simulate profile modification
    _isProfileModified = true;
  }
}
