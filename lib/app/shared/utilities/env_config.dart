class EnvConfig {
  static late final String baseUrl;
  static late final String appId;

  static void initialize({required String baseUrl, required String appId}) {
    EnvConfig.baseUrl = baseUrl;
    EnvConfig.appId = appId;
  }
}
