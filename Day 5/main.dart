import 'dart:io';
void main(){
  stdout.write('Masukkan angka pertama: ');
  int? a = int.parse(stdin.readLineSync()!);

  stdout.write('Masukkan angka kedua: ');
  int? b = int.parse(stdin.readLineSync()!);

  if(a.check(b)){
    print('\n$a lebih besar atau sama dengan $b');
  } else {
    print('$a lebih kecil dari $b');
  }
  print("\nHasil penjumlahan: ${penjumlahan(a, b)}");
  print("Hasil pengurangan: ${pengurangan(a, b)}");
  print("Hasil perkalian: ${perkalian(a, b)}");
  print("Hasil pembagian: ${(pembagian(a, b)).toStringAsFixed(2)}");
}

int penjumlahan(int a, int b){
  return a + b;
}

int pengurangan(int a, int b){
  return a - b;
}

int perkalian(int a, int b){
  return a * b;
}

double pembagian(int a, int b){
  return a/b;
}

extension IntegerExtension on int {
  bool check(int nilaiLain) {
    return this >= nilaiLain;
  }
}