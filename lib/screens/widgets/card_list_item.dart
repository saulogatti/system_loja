import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  final Color colorAvatar;

  final String title;

  final String subTitle;

  final GestureTapCallback onTap;
  final GestureTapCallback? onDelete;
  const CardListItem({
    super.key,
    required this.colorAvatar,
    required this.title,
    required this.subTitle,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 0,
        titleAlignment: ListTileTitleAlignment.center,

        leading: CircleAvatar(
          backgroundColor: colorAvatar,
          child: Text(
            title[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subTitle),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
