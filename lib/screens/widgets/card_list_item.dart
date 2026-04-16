import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  final Color colorAvatar;

  final String title;

  final String subTitle;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry contentPadding;
  final int titleMaxLines;
  final int subTitleMaxLines;

  final GestureTapCallback onTap;
  final GestureTapCallback? onDelete;
  const CardListItem({
    required this.colorAvatar,
    required this.title,
    required this.subTitle,
    required this.onTap,
    super.key,
    this.onDelete,
    this.margin = const EdgeInsets.only(bottom: 12),
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    this.titleMaxLines = 2,
    this.subTitleMaxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: margin,
      child: Center(
        child: ListTile(
          minLeadingWidth: 0,
          contentPadding: contentPadding,
          minVerticalPadding: 4,
          titleAlignment: ListTileTitleAlignment.center,

          leading: CircleAvatar(
            backgroundColor: colorAvatar,
            child: Text(switch (title.isNotEmpty) {
              true => title[0].toUpperCase(),
              _ => '',
            }, style: const TextStyle(color: Colors.white)),
          ),
          title: Text(
            title,
            maxLines: titleMaxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subTitle,
            maxLines: subTitleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
          isThreeLine: subTitleMaxLines > 1,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onDelete != null)
                Semantics(
                  button: true,
                  label: 'Excluir $title',
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                    tooltip: 'Excluir $title',
                  ),
                ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
