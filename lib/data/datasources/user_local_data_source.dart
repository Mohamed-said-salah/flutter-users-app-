import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheUsers(List<UserModel> users);
  Future<UserModel?> getCachedUser(int id);
  Future<void> cacheUser(UserModel user);
  Future<void> clearCache();
}

@Injectable(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String CACHED_USERS = 'CACHED_USERS';
  static const String CACHED_USER_PREFIX = 'CACHED_USER_';

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<UserModel>> getCachedUsers() async {
    final jsonString = sharedPreferences.getString(CACHED_USERS);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    final jsonString = json.encode(users.map((user) => user.toJson()).toList());
    await sharedPreferences.setString(CACHED_USERS, jsonString);
  }

  @override
  Future<UserModel?> getCachedUser(int id) async {
    final jsonString = sharedPreferences.getString('$CACHED_USER_PREFIX$id');
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    final jsonString = json.encode(user.toJson());
    await sharedPreferences.setString(
        '$CACHED_USER_PREFIX${user.id}', jsonString);
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(CACHED_USERS);
    // Remove individual cached users
    final keys = sharedPreferences.getKeys();
    for (final key in keys) {
      if (key.startsWith(CACHED_USER_PREFIX)) {
        await sharedPreferences.remove(key);
      }
    }
  }
}
