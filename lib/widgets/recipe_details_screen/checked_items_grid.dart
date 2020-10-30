import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../models/checked_item.dart';

class CheckedItemsGrid extends StatefulWidget {
  final List<CheckedItem> items;
  final String heading;
  CheckedItemsGrid({@required this.items, @required this.heading});
  @override
  _CheckedItemsGridState createState() => _CheckedItemsGridState();
}

class _CheckedItemsGridState extends State<CheckedItemsGrid> {
  void onItemClicked(CheckedItem item) {
    setState(() {
      item.value = !item.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NeumorphicText(
          widget.heading,
          style: NeumorphicStyle(depth: 3, intensity: 1, color: Colors.grey),
          textStyle: NeumorphicTextStyle(
              fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        ),
        Container(
          height: 300,
          child: GridView.builder(
            itemCount: widget.items.length,
            itemBuilder: (ctx, index) => CheckboxListTile(
                title: Text('${widget.items[index].title}'),
                value: widget.items[index].value,
                onChanged: (value) {
                  setState(() {
                    onItemClicked(widget.items[index]);
                  });
                }),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              childAspectRatio: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        ),
      ],
    );
  }
}
