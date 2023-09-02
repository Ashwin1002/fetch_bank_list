import 'package:assign_khalti/common/utils/extensions/size.dart';
import 'package:assign_khalti/common/utils/extensions/space_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../src/home/model/bank_model.dart';

class BankListItemWidget extends StatelessWidget {
  const BankListItemWidget({
    super.key,
    required this.index,
    required this.indexItem,
    required this.isAnimationStart,
  });

  final int index;
  final BankModel indexItem;
  final bool isAnimationStart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.deepPurple.shade100,
      child: AnimatedContainer(
        height: 70.0,
        width: context.width,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 400 + (index * 100)),
        transform: Matrix4.translationValues(
            isAnimationStart ? 0 : context.width, 0, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: indexItem.logo,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.inactiveGray.withOpacity(.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple,
                    ),
                    child: Center(
                      child: Text(
                        indexItem.name.toString().substring(0, 1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              25.0.spaceX,
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: indexItem.name,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: " (${indexItem.swiftCode})")
                            ]),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
