class UserModel {
  String? email;
  String? username;
  String? bio;
  String? profile;
  List? following;
  List? followers;

  UserModel(
      {this.email,
      this.username,
      this.bio,
      this.profile,
      this.following,
      this.followers});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    bio = json['bio'];
    profile = json['profile'];
    following = json['following'];
    followers = json['followers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['bio'] = this.bio;
    data['profile'] = this.profile;
    data['following'] = this.following;
    data['followers'] = this.followers;
    return data;
  }
}
