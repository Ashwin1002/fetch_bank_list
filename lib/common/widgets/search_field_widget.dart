import 'package:animations/animations.dart';
import 'package:assign_khalti/common/utils/extensions/size.dart';
import 'package:assign_khalti/common/utils/extensions/space_extension.dart';
import 'package:assign_khalti/common/widgets/list_loading_widget.dart';
import 'package:assign_khalti/common/widgets/search_list_view_widget.dart';
import 'package:assign_khalti/src/home/logic/bank_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_single_widget.dart';

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({
    super.key,
    double searchBarheight = 0,
  }) : _searchBarheight = searchBarheight;

  final double _searchBarheight;

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: (context, action) {
        return const SearchListWidget();
      },
      closedElevation: 0,
      openElevation: 0,
      closedBuilder: (context, action) {
        return Container(
          height: widget._searchBarheight,
          width: context.width,
          margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          padding: const EdgeInsetsDirectional.fromSTEB(5.5, 0, 5.5, 0),
          decoration: BoxDecoration(
            color: CupertinoColors.inactiveGray.withOpacity(.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.search,
                size: 20.0,
                color: Colors.grey.shade600,
              ),
              8.0.spaceX,
              Flexible(
                child: Text(
                  "Search Bank by Name or Code...",
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.1,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
