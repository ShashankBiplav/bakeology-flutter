import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CheckedItemsGrid extends StatefulWidget {
  final List<dynamic> items;
  CheckedItemsGrid({@required this.items});
  @override
  _CheckedItemsGridState createState() => _CheckedItemsGridState();
}

class _CheckedItemsGridState extends State<CheckedItemsGrid> {
  @override
  Widget build(BuildContext context) {
    var itemsMap =
        widget.items.map((item) => {item: false});
        print(itemsMap);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NeumorphicText(
          'Ingredients',
          style: NeumorphicStyle(depth: 4, intensity: 1, color: Colors.grey),
          textStyle: NeumorphicTextStyle(
              fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        ),
        Container(
          height: 300,
          child: GridView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) => CheckboxListTile(
              title: Text('${widget.items[index]}'),
              value: (itemsMap
                  .elementAt(index)['${widget.items[index]}']),
              onChanged: (value) {
                print(value);
                setState(() {
                  itemsMap.elementAt(index)['${widget.items[index]}'] = value;
                });
              },
            ),
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

  void _toggleCheckedStatus(bool isChecked) {}
}
