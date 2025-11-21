import 'package:flutter/material.dart';
import '../theme_data/theme_data.dart';

class AboutUsPage extends StatelessWidget {
  final String title;
  const AboutUsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = customTheme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
              splashColor: Colors.transparent,   
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,   
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    customTheme.colorScheme.secondary, 
                    const Color(0xFF6BC1D6),  
                    customTheme.colorScheme.primary,
                    customTheme.colorScheme.tertiary,  
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
        Container( 
        margin: const EdgeInsets.only(top: 80), 
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        child:SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tentang Aplikasi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child:
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Aplikasi cuaca ini dirancang untuk memberikan informasi cuaca secara cepat, akurat, dan mudah dipahami. "
                  "Kami ingin memastikan kamu selalu siap menghadapi kondisi cuaca harian.",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black87,
                        height: 1.45,
                      ),
                ),
              ),
            ),
            ),
            const SizedBox(height: 24),
            Text(
              "Fitur Utama",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),

            buildFeatureCard(Icons.wb_sunny, "Perkiraan cuaca harian hingga mingguan."),
            buildFeatureCard(Icons.warning_amber_rounded, "Peringatan cuaca ekstrem (jika tersedia)."),
            buildFeatureCard(Icons.location_on, "Deteksi lokasi otomatis dan manual."),
            buildFeatureCard(Icons.thermostat, "Informasi suhu, angin, kelembapan, dan kondisi lainnya."),

            const SizedBox(height: 24),
            Text(
              "Sumber Data",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Informasi cuaca pada aplikasi ini bersumber dari OpenWeatherMap API, "
                    "salah satu penyedia data cuaca global yang terpercaya.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87,
                          height: 1.45,
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Developer",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Dikembangkan oleh Alvin.\nVersi aplikasi: 1.0.0",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87,
                          height: 1.45,
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      ),
        ])
    );
  }

  Widget buildFeatureCard(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(icon, color: customTheme.colorScheme.secondary, size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
