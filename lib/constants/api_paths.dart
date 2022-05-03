class ApiPaths {
  static const String baseUrl =
      // LocalHost Address
      // "http://0bf3-103-163-182-224.ngrok.io/"
      // "http://10.0.2.2:8000/"

      // Server Address
      "http://147.182.243.56/";
  static const String registerUrl = baseUrl + "user/register";
  static const String loginUrl = baseUrl + "user/login";
  static const String getProfileUrl = baseUrl + "user/profile";
  static const String updateProfileUrl = baseUrl + "user/update";
  static const String getAllPostsUrl = baseUrl + "post/get";
  static const String getPostsByCategory = baseUrl + "post/get_by_category";
  static const String getAllCategoryUrl = baseUrl + "post/category/get";
  static const String addNewPostUrl = baseUrl + "post/create";
  static const String withdrawUrl = baseUrl + "withdraw/create";
  static const String getMyNotificationsUrl = baseUrl + "notification/mine";
  static const String getMyPosts = baseUrl + "post/mine";
  static const String getMySavedPosts = baseUrl + "bookmark/mine";
  static const String searchPosts = baseUrl + "post/search";
  static const String votePosts = baseUrl + "vote/create";
  static const String getWallet = baseUrl + "wallet/get";
  static const String getUser = baseUrl + "user/get";
  static const String bookmarkUrl = baseUrl + "bookmark/attempt";
}
