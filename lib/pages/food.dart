import 'package:flutter/material.dart';

class MealOrderPage extends StatefulWidget {
  const MealOrderPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MealOrderPageState createState() => _MealOrderPageState();
}

class _MealOrderPageState extends State<MealOrderPage> {
  String? _selectedMeal;
  int _quantity = 1;
  // ignore: prefer_final_fields
  List<String> _meals = [
    'Chicken Teriyaki',
    'Beef Bulgogi',
    'Vegetable Curry',
    'Spaghetti Carbonara',
  ];

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _submitOrder() {
    // TODO: Implement submitting order to backend
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Submitted'),
          content: const Text('Thank you for your order!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Choose a meal:'),
                    const SizedBox(height: 8.0),
                    DropdownButton<String>(
                      value: _selectedMeal,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedMeal = newValue;
                        });
                      },
                      items: _meals.map((String meal) {
                        return DropdownMenuItem<String>(
                          value: meal,
                          child: Text(meal),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Quantity:'),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _decrementQuantity,
                        ),
                        Text(_quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _incrementQuantity,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _submitOrder,
                      child: const Text('Submit Order'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
