import 'dart:io';
import "User.dart";

void main(){
  while (true){
    stdout.write('Masukkan email: ');
    String? email = stdin.readLineSync()!;

    stdout.write('Masukkan password: ');
    String? password = stdin.readLineSync()!;

    User user = User(email, password);
    if(user.login() == "Email atau password salah"){
      print(user.login());
      print("");
      continue;
    } else {
      print(user.login());
      while (true){
        print("\n===== MENU =====");
        print("1. Tampilkan Detail User(Saya)");
        print("2. Cari user dengan email tertentu");
        print("3. Sortir user berdasarkan email");
        print("4. List User admin yang memiliki permission tertentu");
        print("5. List user customer yang berasal di daerah tertentu");
        print("6. Logout");
        stdout.write('\nMasukkan pilihan: ');
        String? pilihan = stdin.readLineSync()!;
        if (pilihan.isEmpty) {
          print('Input tidak boleh kosong!');
        } else if (pilihan[0] == "1"){
          if(email.contains("admin")){
            for(int i = 0; i < userAdmin.length; i++){
              if(email == userAdmin[i]['email']){
                User admin = UserAdmin.fromJson(userAdmin[i]);
                print(admin.detailData());
                break;
              }
            }
          } else {
            for(int i = 0; i < userCustomer.length; i++){
              if(email == userCustomer[i]['email']){
                UserCustomer customer = UserCustomer.fromJson(userCustomer[i]);
                print(customer.detailData());
                break;
              }
            }
          }
        } else if (pilihan[0] == "2"){
          stdout.write('Masukkan email yang dicari: ');
          String? searchEmail = stdin.readLineSync()!;
          if(searchEmail.substring(0,5).toUpperCase() == "ADMIN"){
            for(int i = 0; i < userAdmin.length; i++){
              if(searchEmail == userAdmin[i]['email']){
                User admin = UserAdmin.fromJson(userAdmin[i]);
                print(admin.detailData());
                break;
              }
            }
          } else {
            for(int i = 0; i < userCustomer.length; i++){
              if(searchEmail == userCustomer[i]['email']){
                User customer = UserCustomer.fromJson(userCustomer[i]);
                print(customer.detailData());
                break;
              }
            }
          }
        } else if(pilihan[0] == "3"){
          print("\n=== USER ADMIN ===");
          userAdmin.sort((a, b) => a['email'].compareTo(b['email']));
          List<UserAdmin> admins = userAdmin.map((data) => UserAdmin.fromJson(data)).toList();
          for (var admin in admins) {
            print(admin.detailData());
          }
          print("\n=== USER CUSTOMER ===");
          userCustomer.sort((a, b) => a['email'].compareTo(b['email']));
          List<UserCustomer> customers = userCustomer.map((data) => UserCustomer.fromJson(data)).toList();
          for (var customer in customers) {
            print(customer.detailData());
          }
        } else if(pilihan[0] == "4"){
          bool found = false;
          stdout.write('Masukkan permission yang dicari: ');
          String? searchPermission = stdin.readLineSync()!;
          for(int i = 0; i < userAdmin.length; i++){
            if(userAdmin[i]['permissions'].contains(searchPermission)){
              User admin = UserAdmin.fromJson(userAdmin[i]);
              print(admin.detailData());
              found = true;
            } 
          }
          if (!found) {
            print('Tidak ada admin dengan permission $searchPermission');
          }
        } else if (pilihan[0] == "5"){
          bool found = false;
          stdout.write('Masukkan daerah yang dicari: ');
          String? searchAddress = stdin.readLineSync()!;
          for(int i = 0; i < userCustomer.length; i++){
            if(userCustomer[i]['address'] == searchAddress){
              User customer = UserCustomer.fromJson(userCustomer[i]);
              print(customer.detailData());
              found = true;
            } 
          }
          if (!found){
            print('Tidak ada user yang berasal dari $searchAddress');
          }
        } else if(pilihan[0] == "6") {
          print("Berhasil logout");
          break;
        } else {
          print("Perintah tidak valid");
        }
      }
    }
  }
}