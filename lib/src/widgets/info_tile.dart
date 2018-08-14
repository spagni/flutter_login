import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  InfoTile({@required this.title, @required this.subtitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (icon != null) ? Icon(icon, size: 35.0) : null,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).accentColor
        )
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: 15.0
        )
      ),
    );
  }
}