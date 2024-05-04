import 'package:flutter/material.dart';

// Mock data for income and expense categories
const List<Map<String, dynamic>> categoryData = [
  // Income Categories
  {
    'name': 'Awards',
    'icon': Icons.emoji_events,
    'type': 'income',
  },
  {
    'name': 'Coupons',
    'icon': Icons.confirmation_num,
    'type': 'income',
  },
  {
    'name': 'Grants',
    'icon': Icons.money,
    'type': 'income',
  },
  {
    'name': 'Lottery',
    'icon': Icons.stars,
    'type': 'income',
  },
  {
    'name': 'Refunds',
    'icon': Icons.replay,
    'type': 'income',
  },
  {
    'name': 'Rental',
    'icon': Icons.home,
    'type': 'income',
  },
  {
    'name': 'Salary',
    'icon': Icons.monetization_on,
    'type': 'income',
  },
  {
    'name': 'Sale',
    'icon': Icons.sell,
    'type': 'income',
  },

  // Expense Categories
  {
    'name': 'Baby',
    'icon': Icons.baby_changing_station,
    'type': 'expense',
  },
  {
    'name': 'Beauty',
    'icon': Icons.brush,
    'type': 'expense',
  },
  {
    'name': 'Bills',
    'icon': Icons.receipt_long,
    'type': 'expense',
  },
  {
    'name': 'Car',
    'icon': Icons.directions_car,
    'type': 'expense',
  },
  {
    'name': 'Clothing',
    'icon': Icons.checkroom,
    'type': 'expense',
  },
  {
    'name': 'Education',
    'icon': Icons.school,
    'type': 'expense',
  },
  {
    'name': 'Electronics',
    'icon': Icons.devices,
    'type': 'expense',
  },
  {
    'name': 'Entertainment',
    'icon': Icons.movie,
    'type': 'expense',
  },
  {
    'name': 'Food',
    'icon': Icons.restaurant,
    'type': 'expense',
  },
  {
    'name': 'Health',
    'icon': Icons.health_and_safety,
    'type': 'expense',
  },
  {
    'name': 'Insurance',
    'icon': Icons.security,
    'type': 'expense',
  },
  {
    'name': 'Shopping',
    'icon': Icons.shopping_cart,
    'type': 'expense',
  },
  {
    'name': 'Social',
    'icon': Icons.group,
    'type': 'expense',
  },
  {
    'name': 'Sport',
    'icon': Icons.sports,
    'type': 'expense',
  },
  {
    'name': 'Tax',
    'icon': Icons.money_off,
    'type': 'expense',
  },
  {
    'name': 'Telephone',
    'icon': Icons.phone,
    'type': 'expense',
  },
  {
    'name': 'Transportation',
    'icon': Icons.directions_transit,
    'type': 'expense',
  },
  //Goals
  {
    'name': 'Education',
     'icon':Icons.cast_for_education,
    'type': 'goals',
  },
  {
    'name': 'Vaccation',
    'icon':Icons.beach_access,
    'type': 'goals',
  },
  {
    'name': 'Emergency',
    'icon':Icons.local_hospital,
    'type': 'goals',
  },
  {
    'name': 'Medical Funds',
    'icon':Icons.medical_services,
    'type': 'golas',
  },
  {
    'name': 'Debt Payment',
    'icon':Icons.money,
    'type': 'goals',
  },
  {
    'name': 'Buying Utensils',
    'icon':Icons.car_rental,
    'type': 'goals',
  },
];