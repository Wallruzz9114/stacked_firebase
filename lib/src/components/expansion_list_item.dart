import 'package:flutter/material.dart';
import 'package:stacked_firebase/src/app/constants.dart';

class ExpansionListItem extends StatelessWidget {
  const ExpansionListItem({
    Key key,
    this.onTap,
    this.title,
    this.showArrow = false,
    this.smallVersion = false,
  }) : super(key: key);

  final Function() onTap;
  final String title;
  final bool showArrow;
  final bool smallVersion;

  @override
  GestureDetector build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: smallVersion ? smallFieldHeight : fieldHeight,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  title ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: smallVersion ? 12 : 15),
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[700],
                  size: 20,
                )
              else
                Container()
            ],
          ),
        ),
      );
}
