import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Invitechild extends StatefulWidget {
  const Invitechild({super.key});

  @override
  State<Invitechild> createState() => _InvitechildState();
}

class _InvitechildState extends State<Invitechild> {
  String qrData = '';

  @override
  void initState() {
    super.initState();
    _getUserUID();
  }

  void _getUserUID() async {
    final user = await FirebaseAuth.instance.currentUser;
    final userId = user!.uid;
    final data = {'id': userId, 'app': 'SPENDIFY'};
      setState(() {
        qrData = jsonEncode(data);
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
        child: qrData.isEmpty
            ? CircularProgressIndicator()
            : QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200,
              ),
      ),
    );
  }
}