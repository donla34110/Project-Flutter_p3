import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ตัวแปร cart เพื่อเก็บรายการสินค้าที่ถูกเพิ่มเข้ามา
List<Map<String, dynamic>> cart = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoes Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue, // สีพื้นหลังของ title
          title: const Text(
            'Shoes',
            style: TextStyle(
              color: Colors.white, // สีตัวหนังสือของ title
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50), // กำหนดความสูงของ TabBar
            child: Container(
              color: Colors.deepPurple, // สีพื้นหลังของ TabBar
              child: const TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Sneakers'),
                  Tab(text: 'Football'),
                  Tab(text: 'Running'),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('Products'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllProductsPage(),
            SneakersPage(),
            FootballPage(),
            RunningPage(),
          ],
        ),
      ),
    );
  }
}

// Cart Page
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text('Your cart is empty'),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  leading: Image.network(
                    item['imageUrl'],
                    width: 60,
                    height: 60,
                  ),
                  title: Text(item['brand']),
                  subtitle: Text('Size: ${item['size']}'),
                  trailing: Text(item['price']),
                );
              },
            ),
    );
  }
}

// All Products Page
class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildProductCard(
            context,
            'Nike',
            'Sneakers',
            'https://images.unsplash.com/photo-1538744762222-402d799c0b73?fit=crop&w=500&h=500&q=80',
            '100\$',
            Colors.blue,
          ),
          const SizedBox(height: 10),
          buildProductCard(
            context,
            'Nike',
            'Sneakers',
            'https://images.unsplash.com/photo-1583223916343-d07ddf95d62f?fit=crop&w=500&h=500&q=80',
            '100\$',
            Colors.grey[300]!,
          ),
          const SizedBox(height: 10),
          buildProductCard(
            context,
            'Nike',
            'Sneakers',
            'https://images.unsplash.com/photo-1606813905265-0ff79d0319a8?fit=crop&w=500&h=500&q=80',
            '100\$',
            Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}

// ฟังก์ชัน buildProductCard
Widget buildProductCard(BuildContext context, String brand, String type,
    String imageUrl, String price, Color bgColor) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(
            brand: brand,
            imageUrl: imageUrl,
            price: price,
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Image.network(imageUrl, width: 60, height: 60),
        title: Text(brand, style: const TextStyle(fontSize: 18)),
        subtitle: Text(type),
        trailing: Text(price, style: const TextStyle(fontSize: 18)),
      ),
    ),
  );
}

// Product Details Page (StatefulWidget สำหรับจัดการการเลือก size)
class ProductDetailsPage extends StatefulWidget {
  final String brand;
  final String imageUrl;
  final String price;

  const ProductDetailsPage({
    super.key,
    required this.brand,
    required this.imageUrl,
    required this.price,
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.network(
            widget.imageUrl,
            height: 250,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            widget.brand,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Size',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizeOption(
                size: '40',
                selected: selectedSize == '40',
                onSelect: () {
                  setState(() {
                    selectedSize = '40';
                  });
                },
              ),
              SizeOption(
                size: '42',
                selected: selectedSize == '42',
                onSelect: () {
                  setState(() {
                    selectedSize = '42';
                  });
                },
              ),
              SizeOption(
                size: '44',
                selected: selectedSize == '44',
                onSelect: () {
                  setState(() {
                    selectedSize = '44';
                  });
                },
              ),
              SizeOption(
                size: '46',
                selected: selectedSize == '46',
                onSelect: () {
                  setState(() {
                    selectedSize = '46';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: selectedSize != null
                ? () {
                    // เพิ่มสินค้าลงใน cart
                    cart.add({
                      'brand': widget.brand,
                      'imageUrl': widget.imageUrl,
                      'price': widget.price,
                      'size': selectedSize,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added size $selectedSize to cart!')),
                    );
                  }
                : null, // ปิดการทำงานถ้าไม่ได้เลือก size
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

// SizeOption Widget (ปรับเป็น Stateful เพื่อให้เลือก size ได้)
class SizeOption extends StatelessWidget {
  final String size;
  final bool selected;
  final VoidCallback onSelect;

  const SizeOption({
    super.key,
    required this.size,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Sneakers Page
class SneakersPage extends StatelessWidget {
  const SneakersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildProductCard(
            context,
            'Adidas',
            'Sneakers',
            'https://images.unsplash.com/photo-1518546305925-3f6eafa94486?fit=crop&w=500&h=500&q=80',
            '120\$',
            Colors.blueAccent,
          ),
          const SizedBox(height: 10),
          buildProductCard(
            context,
            'Adidas',
            'Sneakers',
            'https://images.unsplash.com/photo-1512428559087-560fa5ceab42?fit=crop&w=500&h=500&q=80',
            '130\$',
            Colors.redAccent,
          ),
        ],
      ),
    );
  }
}

// Football Page
class FootballPage extends StatelessWidget {
  const FootballPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildProductCard(
            context,
            'Puma',
            'Football Shoes',
            'https://images.unsplash.com/photo-1512218168356-9a4f95f9ab6b?fit=crop&w=500&h=500&q=80',
            '150\$',
            Colors.yellowAccent,
          ),
        ],
      ),
    );
  }
}

// Running Page
class RunningPage extends StatelessWidget {
  const RunningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildProductCard(
            context,
            'Asics',
            'Running Shoes',
            'https://images.unsplash.com/photo-1512218168356-9a4f95f9ab6b?fit=crop&w=500&h=500&q=80',
            '140\$',
            Colors.green,
          ),
        ],
      ),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}

// Products Page
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Center(
        child: Text('Products Page'),
      ),
    );
  }
}
