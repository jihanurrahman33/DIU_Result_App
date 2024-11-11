import 'package:flutter/material.dart';
import 'package:result/controllers/home_screen_controller.dart';

class text_field_container extends StatelessWidget {
  const text_field_container({
    super.key,
    required this.controller,
  });

  final HomeScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextField(
        onChanged: (value) {
          // ignore: invalid_use_of_protected_member
          controller.data.value.clear();
        },
        controller: controller.textFieldController,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        onSubmitted: (value) async {
          await controller.textSubmitController(value);
        },
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          suffixIconColor: Colors.white,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 40, minHeight: 40),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'XXX-XX-XXXX',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          labelText: 'Enter Your ID',
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
