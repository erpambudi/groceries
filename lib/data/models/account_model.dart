import 'package:equatable/equatable.dart';
import 'package:groceries/domain/entities/account.dart';

class AccountResponse extends Equatable {
  const AccountResponse({
    required this.results,
  });

  final List<AccountModel> results;

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      AccountResponse(
        results: List<AccountModel>.from(
            json["results"].map((x) => AccountModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [results];
}

class AccountModel extends Equatable {
  const AccountModel({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.phone,
    required this.cell,
    required this.picture,
    required this.nat,
  });

  final String gender;
  final NameModel name;
  final LocationModel location;
  final String email;
  final LoginModel login;
  final String phone;
  final String cell;
  final PictureModel picture;
  final String nat;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        gender: json["gender"],
        name: NameModel.fromJson(json["name"]),
        location: LocationModel.fromJson(json["location"]),
        email: json["email"],
        login: LoginModel.fromJson(json["login"]),
        phone: json["phone"],
        cell: json["cell"],
        picture: PictureModel.fromJson(json["picture"]),
        nat: json["nat"],
      );

  Account toEntity() {
    return Account(
        gender: gender,
        name: name,
        location: location,
        email: email,
        login: login,
        phone: phone,
        cell: cell,
        picture: picture,
        nat: nat);
  }

  @override
  List<Object?> get props => [
        gender,
        name,
        location,
        email,
        login,
        phone,
        cell,
        picture,
        nat,
      ];
}

class LocationModel extends Equatable {
  const LocationModel({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    // required this.postcode,
  });

  final StreetModel street;
  final String city;
  final String state;
  final String country;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        street: StreetModel.fromJson(json["street"]),
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  @override
  List<Object?> get props => [
        street,
        city,
        state,
        country,
      ];
}

class StreetModel extends Equatable {
  const StreetModel({
    required this.number,
    required this.name,
  });

  final int number;
  final String name;

  factory StreetModel.fromJson(Map<String, dynamic> json) => StreetModel(
        number: json["number"],
        name: json["name"],
      );

  @override
  List<Object?> get props => [
        number,
        name,
      ];
}

class LoginModel extends Equatable {
  const LoginModel({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  final String uuid;
  final String username;
  final String password;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        uuid: json["uuid"],
        username: json["username"],
        password: json["password"],
        salt: json["salt"],
        md5: json["md5"],
        sha1: json["sha1"],
        sha256: json["sha256"],
      );

  @override
  List<Object?> get props => [
        uuid,
        username,
        password,
        salt,
        md5,
        sha1,
        sha256,
      ];
}

class NameModel extends Equatable {
  const NameModel({
    required this.title,
    required this.first,
    required this.last,
  });

  final String title;
  final String first;
  final String last;

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        title: json["title"],
        first: json["first"],
        last: json["last"],
      );

  @override
  List<Object?> get props => [
        title,
        first,
        last,
      ];
}

class PictureModel extends Equatable {
  const PictureModel({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  final String large;
  final String medium;
  final String thumbnail;

  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(
        large: json["large"],
        medium: json["medium"],
        thumbnail: json["thumbnail"],
      );

  @override
  List<Object?> get props => [
        large,
        medium,
        thumbnail,
      ];
}
