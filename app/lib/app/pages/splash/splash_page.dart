import 'package:delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app/app/core/ui/widgtes/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/app/core/config/env/env.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.colors.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Column(
        children: [
          Container(),
          DeliveryButton(
            label: Env.i['backend_base_Url'] ?? '',
            onPressed: () {},
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Teste'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Text'),
          ),
        ],
      ),
    );
  }
}
