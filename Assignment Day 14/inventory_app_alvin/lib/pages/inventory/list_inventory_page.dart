import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app_alvin/components/theme_data.dart';
import 'package:inventory_app_alvin/models/inventory.dart';
import 'package:inventory_app_alvin/helper/firestore_inventory_helper.dart';

class ListInventoryPage extends StatefulWidget {
  const ListInventoryPage({super.key});

  @override
  State<ListInventoryPage> createState() => _ListInventoryPageState();
}

class _ListInventoryPageState extends State<ListInventoryPage> {
  List<Inventory> inventoryList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Logout"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  bool isAdmin() {
    return FirebaseAuth.instance.currentUser?.email == 'ayam@gmail.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppTheme.primary,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Inventory",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout, size: 28, color: Colors.white),
                        onPressed: logout,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                
                // Buttons
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.primaryDark,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Icon(Icons.inventory, color: Colors.white),
                            Text(
                              "Inventory",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    if (isAdmin())
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/add-category');
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.primaryDark,
                          ),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Icon(Icons.category, color: Colors.white),
                              Text(
                                "Category",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryDark.withValues(alpha: 0.84),
                          blurRadius: 8,
                          offset: Offset(0, -4),
                        ),
                      ]
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28),
                          child: Row(
                            children: [
                              Text(
                                "${inventoryList.length} Items",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: "Poppins"
                                )
                              ),
                              Text(
                                " in inventory",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Poppins"
                                )
                              ),
                            ],
                          ),
                        ),
                       Expanded(
                        child: StreamBuilder<List<Inventory>>(
                          stream: FirestoreInventoryHelper().streamInventory(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
                                    SizedBox(height: 16),
                                    Text("No inventory yet",
                                        style: TextStyle(fontFamily: "Poppins", fontSize: 18))
                                  ],
                                ),
                              );
                            }

                            final inventory = snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemCount: inventory.length,
                              itemBuilder: (context, index) {
                                final item = inventory[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.pushNamed(
                                        context,
                                        '/detail-inventory',
                                        arguments: item,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha:0.12),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(item.productName,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20)),
                                                Row(
                                                  children: [
                                                    Text(item.brand,
                                                        style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w800)),
                                                    Text(
                                                      " - ${item.categoryDetails?.categoryName}",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: item.isActive
                                                        ? Colors.green.withValues(alpha:0.24)
                                                        : Colors.orange.withValues(alpha:0.24),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Text(
                                                    item.isActive ? "Active" : "In Active",
                                                    style: TextStyle(
                                                      color: item.isActive
                                                          ? Colors.green
                                                          : Colors.orange,
                                                      fontFamily: "Poppins",
                                                      fontSize: 12,
                                                      fontWeight:FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "${item.quantity} pcs",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: AppTheme.primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: AppTheme.primaryDark,
              onPressed: () async {
                Navigator.pushNamed(context, "/add-inventory");
              },
              child: Icon(Icons.add, size: 32, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}