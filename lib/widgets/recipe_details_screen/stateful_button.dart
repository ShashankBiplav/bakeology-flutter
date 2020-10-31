import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../screens/chef_detail_screen.dart';

import '../../providers/chef_provider.dart';

class StatefulButton extends StatefulWidget {
  final String chefId;
  StatefulButton({@required this.chefId});

  @override
  _StatefulButtonState createState() => _StatefulButtonState();
}

class _StatefulButtonState extends State<StatefulButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator(),)
        : NeumorphicButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              Provider.of<ChefProvider>(context, listen: false)
                  .fetchAndSetChef(chefId: widget.chefId)
                  .then(
                    (_) => {
                      Navigator.of(context)
                          .pushReplacementNamed(ChefDetailScreen.routeName),
                    },
                  );
            },
            child: Container(
              child: Row(
                children: [
                  Text(
                    'View Info',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
            ),
          );
  }
}
