import 'package:flutter/material.dart';


class UserItem extends StatefulWidget {
  final String data;
  final String dataType;
  final Future<void> Function(String, {required BuildContext context}) editFunc;

  const UserItem({
    required this.data,
    required this.dataType,
    required this.editFunc,
  });

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    final editingController = TextEditingController();
    var _isValid = true;

    bool validate(String value) {
      if (widget.dataType == "Mobile Number") {
        String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regExp = new RegExp(patttern);
        if (value.isEmpty) {
          return false;
        } else if (value.length == 0) {
          return false;
        } else if (!regExp.hasMatch(value)) {
          return false;
        }
        return true;
      } else {
        if (value.isEmpty) {
          return false;
        } else if (value.length < 2) {
          return false;
        } else {
          return true;
        }
      }
    }

    void _editItem() {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            top: const Radius.circular(30),
          ),
        ),
        context: context,
        builder: (ctx) => SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      "Edit ${widget.dataType}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 8,
                    right: 8,
                    left: 8,
                  ),
                  child: TextField(
                  
                    scrollPadding: const EdgeInsets.only(
                      bottom: 50,
                    ),
                    keyboardType: widget.dataType == 'Mobile Number'
                        ? TextInputType.number
                        : TextInputType.name,
                    controller: editingController,
                    onChanged: (val) {
                      setState(() {
                        _isValid = validate(val);
                      });
                    },
                    decoration: InputDecoration(
                      errorText: _isValid ? null : "Please enter right value.",
                      labelText: widget.dataType,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      widget.dataType == "Mobile Number"
                          ? "Verify Number"
                          : "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: editingController.text.isNotEmpty
                        ? _isValid
                            ? () async {
                                try {
                                  await widget
                                      .editFunc(editingController.text,
                                          context: ctx)
                                      .then(
                                    (value) {
                                    Navigator.of(context).canPop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "${widget.dataType} updated successfully!!",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        error.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context).errorColor,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            : null
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                margin: const EdgeInsets.all(8),
                height: 50,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _editItem();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Theme.of(context).backgroundColor,
                child: Text(widget.dataType),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
