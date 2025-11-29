import 'package:flutter/material.dart';
import 'package:inventory_app_alvin/components/theme_data.dart';
import 'package:inventory_app_alvin/models/inventory.dart';
import 'package:inventory_app_alvin/helper/firestore_inventory_helper.dart';

class DetailInventoryPage extends StatefulWidget {
  final Inventory inventory;
  
  const DetailInventoryPage({
    super.key,
    required this.inventory, 
  });

  @override
  State<DetailInventoryPage> createState() => _DetailInventoryPageState();
}

class _DetailInventoryPageState extends State<DetailInventoryPage> {
  bool isDeleting = false;

  Future<void> deleteInventory() async {
    // Confirm dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Inventory"),
        content: Text("Are you sure you want to delete ${widget.inventory.productName}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isDeleting = true);

    try {
      await FirestoreInventoryHelper().deleteInventory(widget.inventory.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inventory deleted successfully")),
      );
      Navigator.pop(context, true); 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete: $e")),
      );
      setState(() => isDeleting = false);
    }
  }

  Future<void> inactiveInventory() async {
    setState(() => isDeleting = true);

    try {
      await FirestoreInventoryHelper().inActiveInventory(widget.inventory);

      setState(() {
        widget.inventory.isActive = !widget.inventory.isActive;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Status updated")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed: $e")),
      );
    }

    setState(() => isDeleting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Detail Inventory",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.account_circle, size: 28, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryDark.withValues(alpha: 0.84),
                      blurRadius: 8,
                      offset: Offset(0, -4),
                    ),
                  ]
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Center(
                        child: Text(
                          widget.inventory.productName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: "Poppins",
                            color: AppTheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: widget.inventory.isActive 
                                ? Colors.green.withValues(alpha:0.1) 
                                : Colors.red.withValues(alpha:0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.inventory.isActive == true ? "Active" : "Inactive",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: widget.inventory.isActive == true
                                  ? Colors.green[700] 
                                  : Colors.red[700],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      _buildDetailRow(
                        "Category",
                        widget.inventory.categoryDetails?.categoryName ?? widget.inventory.category,
                        Icons.category,
                      ),

                      _buildDivider(),
                      
                      _buildDetailRow("Brand", widget.inventory.brand, Icons.business),
                      _buildDivider(),
                      
                      _buildDetailRow("Quantity", "${widget.inventory.quantity} pcs", Icons.inventory_2),
                      _buildDivider(),
                      
                      const SizedBox(height: 24),
                      Text(
                        "Description",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.inventory.description,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Timestamps
                      _buildTimestamp("Created", widget.inventory.createdAt),
                      const SizedBox(height: 8),
                      _buildTimestamp("Updated", widget.inventory.updatedAt),
                      
                      const SizedBox(height: 40),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: isDeleting ? null : deleteInventory,
                              icon: isDeleting 
                                  ? SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Icon(Icons.delete),
                              label: Text("Delete"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: BorderSide(color: Colors.red),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: isDeleting ? null : inactiveInventory,
                              icon: isDeleting 
                                  ? SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Icon(Icons.power_settings_new),
                              label: Text(widget.inventory.isActive == true ? "Inactive" : "Active"),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: widget.inventory.isActive == true ? Colors.orange : Colors.green),
                                backgroundColor: widget.inventory.isActive == true ? Colors.orange : Colors.green,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: isDeleting 
                                  ? null 
                                  : () {
                                      Navigator.pushNamed(
                                        context, 
                                        '/edit-inventory',
                                        arguments: widget.inventory,
                                      );
                                    },
                              icon: Icon(Icons.edit),
                              label: Text("Edit"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 24, color: AppTheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[300], height: 1);
  }

  Widget _buildTimestamp(String label, String timestamp) {
    final date = DateTime.parse(timestamp);
    final formatted = "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    
    return Row(
      children: [
        Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        Text(
          formatted,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}