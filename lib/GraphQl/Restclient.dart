// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:p_l_atter/GraphQl/Fatsecret.dart';
import 'package:cancellation_token_http/http.dart' as http;

class RestClient {
  // if  you don't have one, generate from fatSecret API
  late String consumerKey;

  // if  you don't have one, generate from fatSecret API
  late String consumerKeySecret;

  // creates a new RestClient instance.
  // try to make singleton too avoid multiple instances
  // make sure to set AppConfig consumer keys and secrets.
  RestClient() {
    consumerKey = 'd2878762c850489a8afef972b092a974';
    consumerKeySecret = 'd89d1f9f18c6481e9170c88d680a2ae7';
  }

  /*
   * Sends an API call to "food.search" method on fatSecret APi
   * the method inputs a query string to search in food
   * Return Type [SearchFoodItem]
   * please refer to model package.
   */
  // Future<List<SearchFoodItem>> searchFood(String query) async {
  //   List<SearchFoodItem> list = [];

  //   // FatSecretApi be sure that consumer keys are set before you send a call
  //   FatSecretApi foodSearch = FatSecretApi(
  //     this.consumerKey,
  //     this.consumerKeySecret,
  //     "",
  //     "",
  //   );

  //   var result = await foodSearch
  //       .request({"search_expression": query, "method": "foods.search"})
  //       .then((res) => res.body)
  //       .then(json.decode)
  //       .then((json) => json["foods"])
  //       .then((json) => json["food"])
  //       .catchError((err) {
  //         print(err);
  //       });

  //   // Create a POJO class and parse it
  //   result.forEach((foodItem) => list.add(SearchFoodItem.fromJson(foodItem)));
  //   return list;
  // }

  /*
   * Sends an API call to "profile.create" method on fatSecret APi
   * the method inputs unique user Id
   * Return Type [Map]
   * please refer to fatSecret return types
   */
  // Future<Map> createProfile(String userId) async {
  //   // Be sure that consumer keys are set before you send a call
  //   FatSecretApi api =
  //       FatSecretApi(this.consumerKey, this.consumerKeySecret, "", "");

  //   var response = api.request({"method": "profile.create", "user_id": userId});

  //   var jsonBody = await response.then((res) => res.body).then(json.decode);

  //   if (jsonBody["error"] != null) {
  //     var errorMap = jsonBody["error"];
  //     throw FatSecretException(errorMap["code"], errorMap["message"]);
  //   }

  //   var profile = jsonBody["profile"];
  //   return profile;
  // }

  /*
   * Sends an API call to "profile.get_auth" method on fatSecret APi
   * the method inputs unique user Id
   * Return Type [Map]
   * please refer to fatSecret return types
   */
//   Future<Map> getProfileAuth(String userId) async {
//     //var session = await Preferences().getUserSession();
//     var api =
//         new FatSecretApi(this.consumerKey, this.consumerKeySecret, "", "");
//     var jsonBody = await api
//         .request({"method": "profile.get_auth", "user_id": userId})
//         .then((res) => res.body)
//         .then(json.decode);
// //          .then((json) => json["profile"]);
//     if (jsonBody["error"] != null) {
//       var errorMap = jsonBody["error"];
//       throw new FatSecretException(errorMap["code"], errorMap["message"]);
//     }

//     var profile = jsonBody["profile"];
//     return profile;
//   }

  /*
   * Sends an API call to "food_entries.get_month" method on fatSecret APi
   * the method inputs [Date] and [UserFatSecretAuthModel] optional
   * if you want to access some other user you can set UserFatSecretAuthModel in parameters
   * Return Type [DayNutrientsEntry]
   * please refer to model package
   */
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  List<String> splitByLength(String value, int length) {
    List<String> pieces = [];

    for (int i = 0; i < value.length; i += length) {
      int offset = i + length;
      pieces.add(
          value.substring(i, offset >= value.length ? value.length : offset));
    }
    return pieces;
  }

  Future<http.Response> getUserFavorites(
      String oauth_token, String oauth_secret) async {
    var api =
        FatSecretApi(consumerKey, consumerKeySecret, oauth_token, oauth_secret);
    Map<String, String> params = {
      "method": "recipes.get_favorites",
      "format": "json",
      "oauth_token": oauth_token,
    };

    return api.request(params, null);
  }

  Future<http.Response> removeFavoriteToProfile(
      String oauth_token, String oauth_secret, String recipe_id) async {
    var api =
        FatSecretApi(consumerKey, consumerKeySecret, oauth_token, oauth_secret);
    Map<String, String> params = {
      "method": "recipe.delete_favorite",
      "format": "json",
      "oauth_token": oauth_token,
      "recipe_id": recipe_id,
    };

    return api.request(params, null);
  }

  Future<http.Response> addFavoriteToProfile(
      String oauth_token, String oauth_secret, String recipe_id) async {
    var api =
        FatSecretApi(consumerKey, consumerKeySecret, oauth_token, oauth_secret);
    Map<String, String> params = {
      "method": "recipe.add_favorite",
      "format": "json",
      "oauth_token": oauth_token,
      "recipe_id": recipe_id,
    };

    return api.request(params, null);
  }

  Future<http.Response> profileCreate(String id) async {
    var api = FatSecretApi(consumerKey, consumerKeySecret, "", "");
    Map<String, String> params = {
      "method": "profile.create",
      "format": "json",
      "recipe_id": id,
    };

    return api.request(params, null);
  }

  Future<http.Response> recipesDetail(String id) async {
    var api = FatSecretApi(consumerKey, consumerKeySecret, "", "");
    Map<String, String> params = {
      "method": "recipe.get",
      "format": "json",
      "recipe_id": id,
    };

    return api.request(params, null);
  }

  Future<http.Response> getRecipesTypes() async {
    var api = FatSecretApi(consumerKey, consumerKeySecret, "", "");
    Map<String, String> params = {
      "method": "recipe_types.get",
      "format": "json",
    };

    return api.request(params, null);
  }

  Future<http.Response> recipesSearchv1(String query,
      {String recipe_type = ""}) async {
    var api = FatSecretApi(consumerKey, consumerKeySecret, "", "");
    Map<String, String> params = {
      "method": "recipes.search",
      "format": "json",
    };

    if (recipe_type.isNotEmpty) {
      params["recipe_type"] = recipe_type;
    }

    if (query.isNotEmpty) {
      params["search_expression"] = query;
    }

    print("Request params");
    print(params);
    return api.request(params, null);
  }

  Future<http.Response> recipesSearch(String query,
      {String recipe_type = "",
      num page_number = 0,
      num max_results = 50,
      http.CancellationToken? canceltoken}) async {
    var api = FatSecretApi(consumerKey, consumerKeySecret, "", "");
    Map<String, String> params = {
      "method": "recipes.search.v2",
      "format": "json",
      "must_have_images": "true",
      "page_number": "$page_number",
      "max_results": "$max_results"
    };

    if (recipe_type.isNotEmpty) {
      params["recipe_type"] = recipe_type;
    }

    if (query.isNotEmpty) {
      params["search_expression"] = query;
    }

    if (canceltoken != null) {
      return api.request(params, canceltoken);
    }

    print("Request params");
    print(params);
    return api.request(params, null);
  }
}
