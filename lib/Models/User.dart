class User {
  late String password;
  late bool superuser;
  late String email;
  late String name;
  late String address;
  late String city;
  late String codpostal;
  late String phoneNum;
  late bool rss;
  late bool isActive;
  late bool isStaff;
  late int countryID;
  late DateTime lastLogin;

  User(p, s, e, n, a, c, cod, phn, r, ia, iS, cid, l) {
    password = p;
    superuser = s;
    email = e;
    name = n;
    address = a;
    city = c;
    codpostal = cod;
    phoneNum = phn;
    rss = r;
    isActive = ia;
    isStaff = iS;
    countryID = cid;
    lastLogin = l;
  }
}
