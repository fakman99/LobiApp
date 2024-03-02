class User {
  int id;
  String username;
  String firstName;
  String email;
  String passwordHashed;
  List<String> lobbys;
  Map<String, dynamic> rating;
  String description;
  String profilePicture;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.email,
    required this.passwordHashed,
    required this.lobbys,
    required this.rating,
    required this.description,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['Id'],
      username: json['Username'],
      firstName: json['Prénom'],
      email: json['E-mail address'],
      passwordHashed: json['Password_hashed'],
      lobbys: json['Lobbys'],
      rating: json['Rating'],
      description: json['Description'],
      profilePicture: json['Profil_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Username'] = this.username;
    data['Prénom'] = this.firstName;
    data['E-mail address'] = this.email;
    data['Password_hashed'] = this.passwordHashed;
    data['Lobbys'] = this.lobbys;
    data['Rating'] = this.rating;
    data['Description'] = this.description;
    data['Profil_picture'] = this.profilePicture;
    return data;
  }
}