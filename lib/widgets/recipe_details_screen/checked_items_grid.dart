import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../models/checked_item.dart';
import './heading.dart';

class CheckedItemsGrid extends StatefulWidget {
  final List<CheckedItem> items;
  final String heading;
  CheckedItemsGrid({@required this.items, @required this.heading});
  @override
  _CheckedItemsGridState createState() => _CheckedItemsGridState();
}

class _CheckedItemsGridState extends State<CheckedItemsGrid> {
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
            height: isPortrait ? height * 0.2 : height * 0.3,
            child: GridView.builder(
              itemCount: widget.items.length,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Neumorphic(
                  child: Center(
                    child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('${widget.items[index].title}'),
                        value: widget.items[index].value,
                        onChanged: (value) {
                          setState(() {
                            _onItemClicked(widget.items[index]);
                          });
                        }),
                  ),
                ),
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: isPortrait
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width / 3,
                childAspectRatio: 3.5,
                crossAxisSpacing: 0,
                mainAxisSpacing: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
