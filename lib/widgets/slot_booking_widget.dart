import 'package:flutter/material.dart';

class SlotBookingWidget extends StatefulWidget {
  @override
  _SlotBookingWidgetState createState() => _SlotBookingWidgetState();
}

class _SlotBookingWidgetState extends State<SlotBookingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  scrollPadding: const EdgeInsets.only(bottom: 50),
                  decoration: InputDecoration(
                    labelText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  scrollPadding: const EdgeInsets.only(bottom: 50),
                  decoration: InputDecoration(
                    labelText: "Enter Product",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  scrollPadding: const EdgeInsets.only(bottom: 50),
                  decoration: InputDecoration(
                    labelText: "Enter Quantity",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  scrollPadding: const EdgeInsets.only(bottom: 50),
                  decoration: InputDecoration(
                    labelText: "Enter Aadhar Card Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  scrollPadding: const EdgeInsets.only(bottom: 50),
                  decoration: InputDecoration(
                    labelText: "Enter Mobile Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  scrollPadding: const EdgeInsets.only(bottom: 50),
                  decoration: InputDecoration(
                    labelText: "Enter Aadhar Card Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
