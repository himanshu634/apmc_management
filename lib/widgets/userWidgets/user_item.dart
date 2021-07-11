import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String data;
  final String dataType;

  const UserItem({
    required this.data,
    required this.dataType,
  });

  @override
  Widget build(BuildContext context) {
    void _editItem() {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        builder: (ctx) => Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 8,
                  right: 8,
                  left: 8,
                ),
                child: TextField(
                  scrollPadding: const EdgeInsets.only(
                    bottom: 50,
                  ),
                  decoration: InputDecoration(
                    labelText: dataType,
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
                  child: Text("Submit"),
                  onPressed: () {},
                ),
              ),
            ],
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
                      data,
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
                child: Text(dataType),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
