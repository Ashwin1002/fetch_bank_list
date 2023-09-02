import 'package:assign_khalti/common/utils/extensions/size.dart';
import 'package:assign_khalti/common/utils/extensions/space_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BankLoadingItem extends StatelessWidget {
  const BankLoadingItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.7),
      highlightColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Row(
          children: [
            Flexible(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: CupertinoColors.inactiveGray.withOpacity(.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            25.0.spaceX,
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15,
                    width: context.width,
                    color: CupertinoColors.inactiveGray.withOpacity(.2),
                  ),
                  5.0.spaceY,
                  Container(
                    height: 15,
                    width: context.width - 300,
                    color: CupertinoColors.inactiveGray.withOpacity(.2),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
