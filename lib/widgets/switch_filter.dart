import 'package:flutter/material.dart';

class SwitchFilter extends StatelessWidget {
  const SwitchFilter(
      {super.key,
      required this.isChecked,
      required this.changeSwitch,
      required this.subtitle,
      required this.title});

  final String title;
  final String subtitle;
  final bool isChecked;
  final void Function(bool onChanged) changeSwitch;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(right: 22, left: 34),
      value: isChecked,
      onChanged: changeSwitch,
    );
  }
}
