import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';

import 'commodity_selector.dart';
import '../../providers/commodity_detail.dart';

class SlotBookingWidget extends StatefulWidget {
  @override
  _SlotBookingWidgetState createState() => _SlotBookingWidgetState();
}

class _SlotBookingWidgetState extends State<SlotBookingWidget> {
  String? _name;
  String? _commodity;
  int? _quantity;
  String? _aadharCardNumber;
  String? _mobileNumber;
  DateTime? _selectedDate;
  late List<Map<String, dynamic>> commodityItems;

  var _formKey = GlobalKey<FormState>();

  void _selectCommodity(String value) {
    Navigator.of(context).pop();
    setState(() {
      _commodity = value;
    });
  }

  void _selectDate() {
    if (_commodity != null) {
      Map<String, dynamic> commodityItem =
          commodityItems.firstWhere((element) => element['name'] == _commodity);
      showDatePicker(
        context: context,
        initialDate: commodityItem['start_date'],
        firstDate: commodityItem['start_date'],
        lastDate: commodityItem['end_date'],
      ).then((_date) {
        if (_date == null) {
          return;
        } else {
          setState(() {
            _selectedDate = _date;
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Select Commodity first!!",
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      );
    }
  }

//TODO data sending to server is pending
  void _onSubmit() {
    bool _isValidate = _formKey.currentState!.validate();
    if (_isValidate && _selectedDate != null) {
      _formKey.currentState!.save();
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Please Select Date.",
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
              TextButton(
                child: Text(
                  "Select Date",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  _selectDate();
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    commodityItems = Provider.of<CommodityDetail>(context).items;

    //#This is Date Selcter
    Widget _buildDateSelecter() => InkWell(
          onTap: _selectDate,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: _selectedDate == null
                            ? Theme.of(context).errorColor
                            : Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        _selectedDate == null
                            ? "Select Date"
                            : DateFormat.yMd().format(_selectedDate!),
                        style: TextStyle(
                          color: _selectedDate == null
                              ? Theme.of(context).errorColor
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                // ),
                const SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    // style: TextButton.styleFrom(
                    //   backgroundColor: _selectedDate == null
                    //       ? Theme.of(context).errorColor
                    //       : Theme.of(context).primaryColor,
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          _selectedDate == null
                              ? "Select Date"
                              : "Date Selected",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          _selectedDate == null
                              ? Icons.calendar_today
                              : Icons.check,
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                    onPressed: _selectDate,
                  ),
                ),
              ],
            ),
          ),
        );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return "Please enter your name.";
                    if (val.length < 7)
                      return "Minimum 6 characters are required.";
                  },
                  onSaved: (val) => _name = val,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  scrollPadding: const EdgeInsets.only(bottom: 100),
                  decoration: InputDecoration(
                    labelText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              CommoditySelector(
                onSelect: _selectCommodity,
                commodityName: _commodity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return "Please enter Quantity";
                    if (int.parse(val) == 0) return "Quantity can not be 0";
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _quantity = int.parse(val!),
                  textInputAction: TextInputAction.next,
                  scrollPadding: const EdgeInsets.only(bottom: 100),
                  decoration: InputDecoration(
                    labelText: "Enter Quantity(Kilos)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              _buildDateSelecter(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return "Please enter Aadhar number";
                    if (val.length < 12)
                      return "Please enter valid Aadhar Number";
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _aadharCardNumber = val,
                  textInputAction: TextInputAction.next,
                  scrollPadding: const EdgeInsets.only(bottom: 100),
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
                  validator: (value) {
                    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(patttern);
                    if (value == null) {
                      return "Please enter a Mobile Number";
                    } else if (value.length == 0) {
                      return 'Please enter a Mobile Number';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Please enter a valid Mobile Number';
                    }
                    return null;
                  },
                  onEditingComplete: () => _onSubmit(),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _mobileNumber = val,
                  textInputAction: TextInputAction.done,
                  scrollPadding: const EdgeInsets.only(bottom: 100),
                  decoration: InputDecoration(
                    labelText: "Enter Mobile Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Verify Your Mobile Number"),
                      const Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                  onPressed: _onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
