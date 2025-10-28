List<Map<String,dynamic>> userCustomer = [
  {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "password": "password123",
    "address":"Jakarta"
  },
  {
    "name": "Jane Smith",
    "email": "jane.smith@example.com",
    "password":"secure456",
    "address": "Bandung"
  },
  {
    "name": "Andi Pratama",
    "email": "andi.pratama@example.com",
    "password": "flutter789",
    "address":"Surabaya"
  },
  {
    "name": "Siti Rahma",
    "email": "siti.rahma@example.com",
    "password":"coding001",
    "address": "Yogyakarta"
  },
  {
    "name": "Budi Santoso",
    "email": "budi.santoso@example.com",
    "password":"passpass",
    "address": "Semarang"
  }
]; 

List<Map<String,dynamic>> userAdmin = [
  {
    "email": "admin1@example.com",
    "password": "adminpass1",
    "permissions": ["add", "edit", "delete"]
  },
  {
    "email": "admin2@example.com",
    "password": "adminpass2",
    "permissions": ["add", "view"]
  },
  {
    "email": "admin3@example.com",
    "password": "adminpass3",
    "permissions": ["edit", "delete"]
  },
  {
    "email": "admin4@example.com",
    "password": "adminpass4",
    "permissions": ["view"]
  },
  {
    "email": "admin5@example.com",
    "password": "adminpass5",
    "permissions": ["add", "edit"]
  }
];

class User{
  String _email;
  String _password;

  User(this._email, this._password);

  String get email => _email;
  String get password => _password;

  set email(String email) => _email = email;

  String login(){
    String res = "";
    if(email.contains("admin")){
      for (int i = 0; i < userAdmin.length; i++){
        if (email == userAdmin[i]['email'] && password == userAdmin[i]['password']){
          res = "User dengan role admin berhasil login. Halo $email";
          break;
        } else {
          res = "Email atau password salah";
        }
      }
    } else {
      for (int i = 0; i < userCustomer.length; i++){
        if (email == userCustomer[i]['email'] && password == userCustomer[i]['password']){
          res = "User dengan role customer berhasil login. Halo $email";
          break;
        } else {
          res = "Email atau password salah";
        }
      }
    }
    return res;
  }

  String detailData(){
    return "";
  }
}

class UserAdmin extends User {
  List<String> permissions;

  UserAdmin(String email, String password, this.permissions) : super(email, password);

  @override
  String detailData() {
    return """Berikut data user admin:
    email: ${this.email}""";
  }

  factory UserAdmin.fromJson(Map<String, dynamic> json) {
    return UserAdmin(
      json['email'],
      json['password'],
      json['permissions'],
    );
  }
}

class UserCustomer extends User {
  String name;
  String address;

  UserCustomer(String email, String password, this.name, this.address) : super(email, password);

  @override
  String detailData() {
    return """Berikut data user customer:
    email: ${this.email}
    name: ${this.name}
    address: ${this.address}""";
  }

  factory UserCustomer.fromJson(Map<String, dynamic> json) {
    return UserCustomer(
      json['email'],
      json['password'],
      json['name'],
      json['address'],
    );
  }
}