import 'package:flutter/material.dart';
import 'package:inventory_app_alvin/components/theme_data.dart';
import 'package:inventory_app_alvin/models/inventory.dart';
import 'package:inventory_app_alvin/helper/firestore_inventory_helper.dart';
import 'package:inventory_app_alvin/helper/firestore_category_helper.dart';
import 'package:inventory_app_alvin/models/category.dart';

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({super.key});

  @override
  State<AddInventoryPage> createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  List<Category> categories = [];
  bool isLoading = false;
  bool isFetchingCategories = true;

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  Future<void> fetchCategory() async {
    try {
      final fetchedCategories = await FirestoreCategoryHelper().getAllCategory();
      setState(() {
        categories = fetchedCategories;
        isFetchingCategories = false;
      });
    } catch (e) {
      setState(() => isFetchingCategories = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load categories: $e")),
      );
    }
  }

  Future<void> saveInventory() async {
    final name = nameController.text.trim();
    final brand = brandController.text.trim();
    final quantity = int.tryParse(quantityController.text.trim());
    final desc = descriptionController.text.trim();

    if (name.isEmpty || brand.isEmpty || quantity == null || desc.isEmpty || selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields must be filled")),
      );
      return;
    }

    setState(() => isLoading = true);

    final now = DateTime.now().toIso8601String();
    final inventory = Inventory(
      id: null,
      productName: name,
      category: selectedCategory!,
      brand: brand,
      quantity: quantity,
      description: desc,
      createdAt: now,
      updatedAt: now,
      isActive: true,
    );

    try {
      await FirestoreInventoryHelper().addInventory(inventory);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isFetchingCategories
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    "Add Inventory",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Row(
                            children: const [
                              Text(
                                "Product Name",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text("*", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Enter product name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Category Dropdown
                          Row(
                            children: const [
                              Text(
                                "Category",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text("*", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            initialValue: selectedCategory,
                            hint: Text("Select category"),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category.id,
                                child: Text(category.categoryName),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => selectedCategory = value);
                            },
                          ),
                          const SizedBox(height: 24),

                          // Brand
                          Row(
                            children: const [
                              Text(
                                "Brand",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text("*", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: brandController,
                            decoration: InputDecoration(
                              hintText: "Enter brand name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Quantity
                          Row(
                            children: const [
                              Text(
                                "Quantity",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text("*", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Enter quantity",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Description
                          Row(
                            children: const [
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text("*", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: descriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: "Enter description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : saveInventory,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                backgroundColor: AppTheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: isLoading
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      "Save Inventory",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    brandController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}