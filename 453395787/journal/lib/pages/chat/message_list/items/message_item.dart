import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../model/message.dart';
import '../../../../utils/insets.dart';
import '../../../../utils/radius.dart';
import '../../../../utils/text_styles.dart';

part 'item_images.dart';
part 'item_text.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.message,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
  });

  final Message message;
  final void Function(Message message, bool isSelected)? onTap;
  final void Function(Message message, bool isSelected)? onLongPress;
  final bool isSelected;

  double get _widthScaleFactor => isSelected ? 0.75 : 0.8;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LimitedBox(
              maxWidth: MediaQuery.of(context).size.width * _widthScaleFactor,
              child: Card(
                color: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.onPrimary,
                margin: const EdgeInsets.symmetric(
                  vertical: Insets.extraSmall,
                  horizontal: Insets.large,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Radius.medium,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    if (onTap != null) {
                      onTap!(
                        message,
                        isSelected,
                      );
                    }
                  },
                  onLongPress: () {
                    if (onLongPress != null) {
                      onLongPress!(
                        message,
                        isSelected,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(
                    Radius.medium,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Insets.extraSmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (message.images.isNotEmpty)
                          _MessageImages(
                            message: message,
                          ),
                        if (message.text.isNotEmpty)
                          _MessageText(
                            text: message.text,
                          ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (message.isFavorite)
                              Icon(
                                Icons.bookmark,
                                color: Colors.yellow[600],
                                size: 18,
                              ),
                            _MessageTime(
                              time: message.time,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
