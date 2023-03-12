import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Material(
        child: ListTile(
          title: const Text("Schedule Restaurant"),
          trailing: Consumer<SettingProvider>(
            builder: (context, scheduled, _) {
              return Switch(
              value: scheduled.isScheduled, 
              onChanged: (value) async {
                scheduled.scheduleInfo(value);
              });
            } ),
        ),
      ),
    );
  }
}