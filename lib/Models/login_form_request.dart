class login_form_request {
  String? user;
  String? pass;

  login_form_request({required this.user, required this.pass});

  login_form_request.fromJson(Map<String, dynamic> json) {
    user = json['username'];
    pass = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.user;
    data['password'] = this.pass;
    return data;
  }
}
