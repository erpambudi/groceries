import 'package:equatable/equatable.dart';

import '../../data/models/account_model.dart';

class Account extends Equatable {
  const Account({
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

class Location extends Equatable {
  const Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
  });

  final StreetModel street;
  final String city;
  final String state;
  final String country;

  @override
  List<Object?> get props => [
        street,
        city,
        state,
        country,
      ];
}

class Street extends Equatable {
  const Street({
    required this.number,
    required this.name,
  });

  final int number;
  final String name;

  @override
  List<Object?> get props => [
        number,
        name,
      ];
}

class Login extends Equatable {
  const Login({
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

class Name extends Equatable {
  const Name({
    required this.title,
    required this.first,
    required this.last,
  });

  final String title;
  final String first;
  final String last;

  @override
  List<Object?> get props => [
        title,
        first,
        last,
      ];
}

class Picture extends Equatable {
  const Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  final String large;
  final String medium;
  final String thumbnail;

  @override
  List<Object?> get props => [
        large,
        medium,
        thumbnail,
      ];
}
