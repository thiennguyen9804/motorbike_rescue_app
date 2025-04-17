import 'dart:convert';

import 'package:mmkv/mmkv.dart';
import 'package:motorbike_rescue_app/data/dto/local_user.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';
import 'package:motorbike_rescue_app/data/dto/tokens.dart';
import 'package:motorbike_rescue_app/exception/no_tokens_exceptions.dart';

abstract class AuthLocalService {
  void writeTokens(Tokens tokens);
  Tokens getTokens();
  void writeUserToLocal(LocalUser data);
  LocalUser getLocalUser();
}

class AuthLocalServiceImpl implements AuthLocalService {
  final mmkv = MMKV.defaultMMKV();

  @override
  LocalUser getLocalUser() {
    final data = mmkv.decodeString('localUser');
    final user = LocalUser.fromJson(jsonDecode(data!));
    return user;
  }

  @override
  Tokens getTokens() {
    final str = mmkv.decodeString('tokens');
    if(str == null) {
      throw NoTokensExceptions();
    }
    return Tokens.fromJson(jsonDecode(str));
  }

  @override
  void writeTokens(Tokens tokens) {
    final data = jsonEncode(tokens.toJson());
    mmkv.encodeString('tokens', data);

  }

  @override
  void writeUserToLocal(LocalUser data) {
    mmkv.encodeString('localUser', jsonEncode(data.toJson()));
  }

}





