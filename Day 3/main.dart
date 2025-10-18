void main(){
  namaHari(1);
  namaHari(5);
  namaHari(9);

  cekAngka(7);
  cekAngka(12);
}

void namaHari(int nomor){
  switch(nomor){
    case 1:
      print("Senin");
      break;
    case 2:
      print("Selasa");
      break;
    case 3:
      print("Rabu");
      break;
    case 4:
      print("Kamis");
      break;
    case 5:
      print("Jum'at");
      break;
    case 6:
      print("Sabtu");
      break;
    case 7:
      print("Minggu");
      break;
    default:
      print("Nomor hari tidak valid");
  }
}

void cekAngka(int angka){
  if (angka % 2 == 0){
    print("Angka $angka adalah genap");
  } else {
    print("Angka $angka adalah ganjil");
  }
}