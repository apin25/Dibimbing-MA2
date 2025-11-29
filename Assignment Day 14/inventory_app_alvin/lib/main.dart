import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:inventory_app_alvin/pages/authentication/login_page.dart';
import 'package:inventory_app_alvin/pages/authentication/register_page.dart';
import 'package:inventory_app_alvin/pages/category/add_category.dart';
import 'package:inventory_app_alvin/pages/inventory/add_inventory_page.dart';
import 'package:inventory_app_alvin/pages/inventory/detail_inventory_page.dart';
import 'package:inventory_app_alvin/pages/inventory/edit_inventory_page.dart';
import 'package:inventory_app_alvin/pages/inventory/list_inventory_page.dart';
import 'package:inventory_app_alvin/models/inventory.dart';
import './components/theme_data.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory App',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),  // ✅ Start dari login
        '/register': (context) => const RegisterPage(),
        '/inventory': (context) => const ListInventoryPage(),
        '/add-inventory': (context) => const AddInventoryPage(),
        '/add-category': (context) => const AddCategoryPage(),
      },
      onGenerateRoute: (settings) {
        // ✅ Handle routes yang butuh arguments
        if (settings.name == '/detail-inventory') {
          final inventory = settings.arguments as Inventory;
          return MaterialPageRoute(
            builder: (context) => DetailInventoryPage(inventory: inventory),
          );
        }
        
        if (settings.name == '/edit-inventory') {
          final inventory = settings.arguments as Inventory;
          return MaterialPageRoute(
            builder: (context) => EditInventoryPage(inventory: inventory),
          );
        }
        
        return null;
      },
    );
  }
}