import 'package:flutter/material.dart';
import 'package:stacked_firebase/src/app/constants.dart';
import 'package:stacked_firebase/src/components/expansion_list_item.dart';

class ExpansionList<T> extends StatefulWidget {
  const ExpansionList({
    Key key,
    this.items,
    this.title,
    @required this.onItemSelected,
    this.smallVersion = false,
  }) : super(key: key);

  @override
  _ExpansionListState createState() => _ExpansionListState();

  final List<T> items;
  final String title;
  final Function(dynamic) onItemSelected;
  final bool smallVersion;
}

class _ExpansionListState extends State<ExpansionList<dynamic>> {
  final double startingHeight = fieldHeight;
  double expandedHeight;
  bool expanded = false;
  String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.title;
    _calculateExpandedHeight();
  }

  @override
  AnimatedContainer build(BuildContext context) => AnimatedContainer(
        padding: fieldPadding,
        duration: const Duration(milliseconds: 180),
        height: expanded
            ? expandedHeight
            : widget.smallVersion ? smallFieldHeight : startingHeight,
        decoration: fieldDecortaion.copyWith(
          boxShadow: expanded
              ? <BoxShadow>[BoxShadow(blurRadius: 10, color: Colors.grey[300])]
              : null,
        ),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            ExpansionListItem(
              title: selectedValue,
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              showArrow: true,
              smallVersion: widget.smallVersion,
            ),
            Container(
              height: 2,
              color: Colors.grey[300],
            ),
            ..._getDropdownListItems()
          ],
        ),
      );

  List<Widget> _getDropdownListItems() => widget.items
      .map((dynamic item) => ExpansionListItem(
          smallVersion: widget.smallVersion,
          title: item.toString(),
          onTap: () {
            setState(() {
              expanded = !expanded;
              selectedValue = item.toString();
            });

            widget.onItemSelected(item);
          }))
      .toList();

  void _calculateExpandedHeight() {
    expandedHeight = 2 +
        (widget.smallVersion ? smallFieldHeight : fieldHeight) +
        (widget.items.length *
            (widget.smallVersion ? smallFieldHeight : fieldHeight));
  }
}
