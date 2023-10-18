class UserData {
  final List<Result> results;
  final Info info;

  UserData({
    required this.results,
    required this.info,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      results: (json['results'] as List)
          .map((resultJson) => Result.fromJson(resultJson))
          .toList(),
      info: Info.fromJson(json['info']),
    );
  }
}

class Result {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final Name name;
  final Picture picture;

  Result({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.picture,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      cell: json['cell'],
      nat: json['nat'],
      name: Name.fromJson(json['name']),
      picture: Picture.fromJson(json['picture']),
    );
  }
}

class Info {
  final String seed;
  final int results;
  final int page;
  final String version;

  Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      seed: json['seed'],
      results: json['results'],
      page: json['page'],
      version: json['version'],
    );
  }
}


class Name {
  final String title;
  final String first;
  final String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}