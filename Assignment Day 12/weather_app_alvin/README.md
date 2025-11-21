## 1. Bagaimana saya memastikan alur berpindah halaman tetap efisien dan mudah dipahami pengguna?

Untuk menjaga alur navigasi tetap efisien dan mudah dipahami, saya menggunakan named routes (Navigator.pushNamed). Pendekatan ini membuat perpindahan halaman menjadi lebih konsisten, karena setiap halaman memiliki nama rute yang jelas dan mudah diingat.

Selain itu, saya selalu melakukan:

- Navigator.pop(context) sebelum pushNamed() pada menu drawer supaya drawer menutup dulu dan UX terasa natural.

- Struktur navigasi dibuat sederhana dan konsisten, di mana setiap item di sidebar menuju halaman yang relevan dengan ikon dan label jelas.

- Halaman disusun dengan pola layout yang mirip, sehingga pengguna tidak perlu belajar ulang saat berpindah halaman.

Pendekatan ini membuat alur navigasi tidak membingungkan dan mempermudah pengguna berpindah dari satu halaman ke halaman lain.

## 2. Bagaimana saya mengelola data antar halaman agar akurat dan tidak redundant?

Untuk menghindari duplikasi kode serta menjaga konsistensi data saat berpindah halaman, saya menggunakan beberapa pendekatan:

### a. Memisahkan UI dan data dalam file terpisah

Misalnya:

- Widget sidebar sendiri (side_bar.dart)

- Theme sendiri (theme_data.dart)

- Halaman profil sendiri (profile_page.dart)

### b. Memanfaatkan constructor dan parameter

Jika suatu halaman butuh data spesifik (misalnya cuaca, user info, setting), saya mengirimkannya lewat constructor:
Navigator.pushNamed(context, '/details', arguments: weatherData);

Pendekatan ini menghindari global variable yang rawan salah dan membuat logic berpindah halaman tetap bersih.

### c. Menjaga state di halaman asal

Saat navigasi hanya menampilkan data tanpa mengubah state global, saya cukup biarkan state dikelola oleh halaman induk, bukan oleh setiap halaman baru. Hasilnya, tidak ada duplikasi data dan tidak ada data yang “lepas kontrol”.