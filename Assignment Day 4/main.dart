List<Map<String, dynamic>> dataKaryawan = [
    {
    'nama': 'Alice',
    'departemen': 'Pengembangan',
    'skorKinerja': 4.5,
    'jumlahProyek': 8,
    'tahunGabung': '2022',
    'statusPelatihan':true,
    'gajiPokok': 7000000
    },
    {
    'nama': 'Bob',
    'departemen': 'Pemasaran',
    'skorKinerja': 3.8,
    'jumlahProyek': 5,
    'tahunGabung': '2021',
    'statusPelatihan':false,
    'gajiPokok': 6500000
    },
    {
    'nama': 'Charlie',
    'departemen': 'Pengembangan',
    'skorKinerja': 4.9,
    'jumlahProyek':10,
    'tahunGabung': '2023',
    'statusPelatihan':true,
    'gajiPokok': 8000000
    },
    {
    'nama': 'Diana',
    'departemen': 'HR',
    'skorKinerja': 4.2,
    'jumlahProyek': 3,
    'tahunGabung': '2022',
    'statusPelatihan':true,
    'gajiPokok': 6000000
    },
    {
    'nama': 'Eve',
    'departemen': 'Pemasaran',
    'skorKinerja': 3.5,
    'jumlahProyek': 6,
    'tahunGabung': '2023',
    'statusPelatihan':false,
    'gajiPokok': 6200000
    },
    {
    'nama': 'Frank',
    'departemen': 'Pengembangan',
    'skorKinerja': 4.7,
    'jumlahProyek': 9,
    'tahunGabung': '2021',
    'statusPelatihan':true,
    'gajiPokok': 7500000
    },
    {
    'nama': 'Grace',
    'departemen': 'HR',
    'skorKinerja': 3.0,
    'jumlahProyek': 2,
    'tahunGabung': '2024',
    'statusPelatihan':false,
    'gajiPokok': 5800000
    },
    {
    'nama': 'Heidi',
    'departemen': 'Pengembangan',
    'skorKinerja':4.1,
    'jumlahProyek': 7,
    'tahunGabung': '2022',
    'statusPelatihan':true,
    'gajiPokok': 7200000
    },
  ];
void main(){

  print(keseluruhanGaji());
  print(kinerja());
  print(jumlahBelumPelatihan());
  print(sempurna());
  print(laporan());
  print(rataRataSkor());
  print(proyekDiatasRataRata());
  print(namaBelumPelatihan());
}

// No.1 Berapa total gaji keseluruhan karyawan?
String keseluruhanGaji(){
  double totalGaji = 0;
  for(Map<String, dynamic> data in dataKaryawan){
      totalGaji += data['gajiPokok'];
  }
  return('1. Total gaji keseluruhan karyawan adalah: ${totalGaji.toStringAsFixed(2)}\n');
}

  // No.2 Siapa saja karyawan yang memiliki kinerja diatas 4.0?
String kinerja(){
  int i = 0;
  String result = "";
  while (i < dataKaryawan.length){
    if (dataKaryawan[i]['skorKinerja'] >= 4.0) {
      result += i == dataKaryawan.length-1 ? "${dataKaryawan[i]['nama']}": "${dataKaryawan[i]['nama']}, ";
    }
    i++;
  }
  return("2. Karyawan Berkinerja Di Atas 4.0: $result\n");
}

 //No. 3 Berapa jumlah karyawan yang belum melakukan pelatihan?
String jumlahBelumPelatihan(){
  int belum = 0;
  int i = 0;
  do {
    if(dataKaryawan[i]['statusPelatihan'] == false){
      belum++;
    }
    i++;
  } while (i < dataKaryawan.length);
  return("3. Jumlah karyawan yang belum melakukan pelatihan: $belum orang\n");
}

// No. 4 Apakah ada karyawan yang memiliki nilai kinerja sempurna (5.0)?
String sempurna(){
  String result = "";
  for (int i = 0; i < dataKaryawan.length; i++){
    if (dataKaryawan[i]['skorKinerja'] == 5.0){
      result += i == dataKaryawan.length-1 ? "${dataKaryawan[i]['nama']}\n": "${dataKaryawan[i]['nama']}, ";
    } 
  }
  result = result == "" ? "Tidak": result;
  return "4. Ada karyawan dengan Skor kinerja 5.0: ${result}\n";
}

//No. 5 Membuatlaporan ringkasan masing-masing karyawan yang terdiri nama, departemen, dan skor kinerja.
String laporan(){
  String result = "5. Laporan Ringkas Karyawan\n";
  dataKaryawan.forEach((karyawan) {
    result += "   {nama: ${karyawan['nama']}, : departemen: ${karyawan['departemen']}, skorKinerja: ${karyawan['skorKinerja']}}\n";
  });
  return result;
}

//No. 6 Berapa skor rata-rata projek dari keseluruhan karyawan?
String rataRataSkor(){
  double totalSkor = 0;
  for(Map<String, dynamic> data in dataKaryawan){
      totalSkor += data['skorKinerja'];
  }
  double rataRata = totalSkor/dataKaryawan.length;
  return "6. Rata rata skor karyawan: ${rataRata.toStringAsFixed(2)}\n";
}

//No. 7 Siapa saja karyawan pengembangan yang memiliki projek diatas rata-rata? 
String proyekDiatasRataRata(){
  double jumlahProyek = 0;
  for(Map<String, dynamic> data in dataKaryawan){
      jumlahProyek += data['jumlahProyek'];
  }
  double rataRata = jumlahProyek/dataKaryawan.length;
  String namaKaryawan = dataKaryawan
    .where((e)=> e['departemen'] == 'Pengembangan' && e['jumlahProyek'] > rataRata)
    .map((e) => e['nama'])
    .join(', ');
    return "7. Karyawan pengembangan yang memiliki proyek di atas rata-rata: $namaKaryawan\n";
}
//No. 8 Siapa saja karyawan yang belum melakukan pelatihan?
String namaBelumPelatihan(){
  String namaKaryawan = dataKaryawan
    .where((e)=> e['statusPelatihan'] == false)
    .map((e) => e['nama'])
    .join(', ');
  return "8. Nama karyawan yang belum pelatihan: $namaKaryawan";
}