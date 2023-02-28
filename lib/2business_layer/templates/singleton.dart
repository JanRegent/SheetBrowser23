class MySingleton {
  static MySingleton _instance = MySingleton._privateConstructor();

  MySingleton._privateConstructor();

  static MySingleton get instance {
    // ignore: unnecessary_null_comparison, prefer_conditional_assignment
    if (_instance == null) {
      _instance = MySingleton._privateConstructor();
    }
    return _instance;
  }
}
