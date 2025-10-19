void main(){
 testDoWhile();
 testWhileLoop();
 testForLoop();
}

void testDoWhile(){
  print('Test Case: Do-While Loop (Simulasi Login)');

  const String passwordBenar = 'flutter123';
  List<String> percobaan = ['dart123','flutter12', 'flutter123'];
  int index = 0;

  do {
    print('Percobaan ke-${index+1}:${percobaan[index]}');
    if (percobaan[index] == passwordBenar){
      print("Login berhasil\n");
      break;
    } else {
      if(index == percobaan.length-1){
        print("Password salah\n");
      } else {
        print("Password salah");
      }
      index++;
    }
  } while (index < percobaan.length);
}

void testWhileLoop(){
  print('Test Case: While Loop (Menabung)');
  int saldo = 0;
  int target = 1000000;
  int minggu = 1;

  while(saldo < target){
    int tabunganMinggu = 100000 + (minggu * 5000);
    print('Minggu ke-$minggu: Nabung $tabunganMinggu');
    minggu++;
    saldo += tabunganMinggu;
  }
  print('Target Rp.$target tercapai dalam ${minggu-1}!\n');
}

void testForLoop(){
  print('test Case: For Loop (Bilangan Genap)');
  int start = 2;
  int end = 30;
  int count = 0;

  for (int i = start; i <= end; i+=2){
    print('$i adalah bilangan genap');
    count++;
  }
  print('Total bilangan genap antara $start-$end: $count\n');
}
