import 'package:flutter/material.dart';
import 'package:webconcept/utlis/app_colors.dart';

// Main Order Detail Screen
class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool isProductsExpanded = false;

  final OrderData orderData = OrderData(
    trackingId: "TRK-5848184331",
    orderNumber: "3",
    status: "In Progress",
    customer: CustomerInfo(
      name: "Awais Ansari",
      contact: "0000-00000000",
      address: "123 Maple Street, Block B, Cityville, State 12345, Country",
    ),
    rider: RiderInfo(
      name: "Rider Name Here",
      contact: "0000-0000000",
      email: "ad@gmail.com",
      vehicleNumber: "FDS-0000",
    ),
    orderDetails: OrderDetails(
      itemCount: 1,
      date: "25 Aug, 2025",
      total: 0000,
      deliveryFee: 0000,
      grandTotal: 0000,
    ),
    products: [
      ProductInfo(
        title: "HD Wireless Bluetooth Headphones with Noise Cancellation",
        quantity: 2,
        size: "Large, Color:black",
        unitPrice: 1200,
      ),
      ProductInfo(
        title: "HD Wireless Bluetooth Headphones with Noise Cancellation",
        quantity: 1,
        size: "Medium, Color:black",
        unitPrice: 800,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VideoUploadSection(),
            const SizedBox(height: 16),
            const ShipmentDetailsForm(),
            const SizedBox(height: 16),
            OrderInfoCard(orderData: orderData),
            const SizedBox(height: 16),
            ProductDetailsCard(
              products: orderData.products,
              isExpanded: isProductsExpanded,
              onToggle: () =>
                  setState(() => isProductsExpanded = !isProductsExpanded),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: const Text(
        "Order Details",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}

// Video Upload Section Widget
class VideoUploadSection extends StatelessWidget {
  const VideoUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.07),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_rounded,
                color: AppColors.themeColor,
                size: size.width * 0.12,
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "Video",
                style: TextStyle(
                  color: AppColors.themeColor,
                  fontSize: size.width * 0.045,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Upload Video (Max 20MB)",
          style: TextStyle(
            color: const Color(0x80333333),
            fontFamily: "Poppins",
            fontSize: size.width * 0.045,
          ),
        ),
      ],
    );
  }
}

// Shipment Details Form Widget
class ShipmentDetailsForm extends StatelessWidget {
  const ShipmentDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildWeightField()),
            SizedBox(width: width * 0.03),
            Expanded(child: _buildSizeField()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildDropdown()),
            SizedBox(width: width * 0.03),
            Expanded(child: _buildSubmitButton()),
          ],
        ),
      ],
    );
  }

  Widget _buildWeightField() {
    return const CustomTextField(label: "Weight (kg)", hintText: "Enter here");
  }

  Widget _buildSizeField() {
    return const CustomTextField(label: "Size", hintText: "2 by 4");
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      hint: const Text(
        "Select option",
        style: TextStyle(fontFamily: "Poppins"),
      ),
      items: const [
        DropdownMenuItem(value: "Option 1", child: Text("Option 1")),
        DropdownMenuItem(value: "Option 2", child: Text("Option 2")),
      ],
      onChanged: (value) {},
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: AppColors.themeColor,
      ),
      child: const Text(
        "Submit",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}

// Custom Text Field Widget
class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.grey,
            ),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

// Order Info Card Widget
class OrderInfoCard extends StatelessWidget {
  final OrderData orderData;

  const OrderInfoCard({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomerInfo(),
                const SizedBox(height: 8),
                _buildOrderInfo(),
                const SizedBox(height: 8),
                _buildTotalInfo(),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                _buildGrandTotal(),
                const SizedBox(height: 8),
                _buildAddress(),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                _buildRiderDetails(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${orderData.orderNumber}/ ${orderData.trackingId}",
              style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          StatusChip(status: orderData.status),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return InfoRow(
      left: "Customer: ${orderData.customer.name}",
      right: "Contact: ${orderData.customer.contact}",
    );
  }

  Widget _buildOrderInfo() {
    return InfoRow(
      left: "Items: ${orderData.orderDetails.itemCount}",
      right: "(Date: ${orderData.orderDetails.date})",
    );
  }

  Widget _buildTotalInfo() {
    return InfoRow(
      left: "Total: ${orderData.orderDetails.total}",
      right: "(Delivery Fee: ${orderData.orderDetails.deliveryFee})",
    );
  }

  Widget _buildGrandTotal() {
    return Text(
      "Grand Total: Rs. ${orderData.orderDetails.grandTotal}",
      style: const TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _buildAddress() {
    return Text(
      "Address: ${orderData.customer.address}",
      style: const TextStyle(
        fontFamily: "Poppins",
        color: Colors.black54,
        fontSize: 11,
      ),
    );
  }

  Widget _buildRiderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rider Details:",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppColors.themeColor,
          ),
        ),
        const SizedBox(height: 8),
        InfoRow(
          left: "Rider: ${orderData.rider.name}",
          right: "Vehicle # : ${orderData.rider.vehicleNumber}",
        ),
        InfoRow(
          left: "Contact #: ${orderData.rider.contact}",
          right: "Email: ${orderData.rider.email}",
        ),
      ],
    );
  }
}

// Product Details Card Widget
class ProductDetailsCard extends StatelessWidget {
  final List<ProductInfo> products;
  final bool isExpanded;
  final VoidCallback onToggle;

  const ProductDetailsCard({
    super.key,
    required this.products,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isExpanded ? null : 0,
            child: isExpanded ? _buildProductList() : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return InkWell(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Product Details",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey[600],
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey.shade300),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) =>
              ProductTile(product: products[index]),
        ),
      ],
    );
  }
}

// Product Tile Widget
class ProductTile extends StatelessWidget {
  final ProductInfo product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              const SizedBox(width: 12),
              Expanded(child: _buildProductInfo()),
            ],
          ),
          const SizedBox(height: 8),
          _buildPriceInfo(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 80,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image, color: Colors.grey, size: 40),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                product.title,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            QuantityChip(quantity: product.quantity),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                "Size: ${product.size}",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const Text(
              "1/2 by 4",
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceInfo() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Unit Price: Rs.${product.unitPrice}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Text(
          "Subtotal: Rs.${product.unitPrice * product.quantity}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
      ],
    );
  }
}

// Reusable Widgets
class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        status,
        style: TextStyle(
          color: AppColors.themeColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}

class QuantityChip extends StatelessWidget {
  final int quantity;

  const QuantityChip({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "Qty: $quantity",
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.themeColor,
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String left;
  final String right;

  const InfoRow({super.key, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.black54,
              fontSize: 11,
            ),
          ),
        ),
        Text(
          right,
          style: const TextStyle(
            fontFamily: "Poppins",
            color: Colors.black54,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

// Data Models
class OrderData {
  final String trackingId;
  final String orderNumber;
  final String status;
  final CustomerInfo customer;
  final RiderInfo rider;
  final OrderDetails orderDetails;
  final List<ProductInfo> products;

  OrderData({
    required this.trackingId,
    required this.orderNumber,
    required this.status,
    required this.customer,
    required this.rider,
    required this.orderDetails,
    required this.products,
  });
}

class CustomerInfo {
  final String name;
  final String contact;
  final String address;

  CustomerInfo({
    required this.name,
    required this.contact,
    required this.address,
  });
}

class RiderInfo {
  final String name;
  final String contact;
  final String email;
  final String vehicleNumber;

  RiderInfo({
    required this.name,
    required this.contact,
    required this.email,
    required this.vehicleNumber,
  });
}

class OrderDetails {
  final int itemCount;
  final String date;
  final int total;
  final int deliveryFee;
  final int grandTotal;

  OrderDetails({
    required this.itemCount,
    required this.date,
    required this.total,
    required this.deliveryFee,
    required this.grandTotal,
  });
}

class ProductInfo {
  final String title;
  final int quantity;
  final String size;
  final int unitPrice;

  ProductInfo({
    required this.title,
    required this.quantity,
    required this.size,
    required this.unitPrice,
  });
}
