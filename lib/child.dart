import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:spendify/service/userData.dart';

class Invitechild extends StatefulWidget {
  final String type;
  const Invitechild({super.key, required this.type});

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
    final String familyId = await UserDataService.getData();
    final data = {'id': familyId, 'app': 'SPENDIFY', 'type': widget.type};
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