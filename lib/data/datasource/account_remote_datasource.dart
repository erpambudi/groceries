import 'dart:convert';

import 'package:groceries/common/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../common/utils/exception.dart';
import '../models/account_model.dart';

abstract class AccountRemoteDatasource {
  Future<AccountModel> getAccount();
}

class AccountRemoteDatasourceImpl implements AccountRemoteDatasource {
  @override
  Future<AccountModel> getAccount() async {
    final response = await http.get(Uri.parse(Constants.accountUrl));

    if (response.statusCode == 200) {
      final data = AccountResponse.fromJson(json.decode(response.body));
      return data.results[0];
    } else {
      throw ServerException();
    }
  }
}
