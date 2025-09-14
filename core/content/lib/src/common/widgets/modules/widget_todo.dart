import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

class GsaWidgetTodo extends StatefulWidget {
  const GsaWidgetTodo({super.key});

  @override
  State<GsaWidgetTodo> createState() => _GsaWidgetTodoState();
}

class _GsaWidgetTodoState extends State<GsaWidgetTodo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(
                GsaTheme.of(context).paddings.content.large,
              ),
              child: Icon(
                Icons.emoji_nature,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          SizedBox(
            height: GsaTheme.of(context).paddings.content.mediumLarge,
          ),
          GsaWidgetText(
            'TODO',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: GsaTheme.of(context).paddings.content.regular,
          ),
        ],
      ),
    );
  }
}
