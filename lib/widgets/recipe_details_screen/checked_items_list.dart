import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../models/checked_item.dart';
import './heading.dart';

class CheckedItemsList extends StatefulWidget {
  final List<CheckedItem> items;
  final String heading;
  CheckedItemsList({@required this.items, @required this.heading});
  @override
  _CheckedItemsListState createState() => _CheckedItemsListState();
}

class _CheckedItemsListState extends State<CheckedItemsList> {
  void _onItemClicked(CheckedItem item) {
    setState(() {
      item.value = !item.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Heading(
            text: widget.heading,
          ),
          Container(
            height: isPortrait ? height * 0.4 : height * 0.6,
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Neumorphic(
                  child: Center(
                    child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          '${widget.items[index].title}',
                          maxLines: 3,
                        ),
                        value: widget.items[index].value,
                        onChanged: (value) {
                          setState(() {
                            _onItemClicked(widget.items[index]);
                          });
                        }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
