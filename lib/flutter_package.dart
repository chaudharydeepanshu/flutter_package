library flutter_package;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProvider = ChangeNotifierProvider((ref) {
  return NotifierClass();
});

class NotifierClass extends ChangeNotifier {
  late String _name;
  String get name => _name;

  initialiseProperty({required String? name}) {
    _name = name ?? "Default";
  }

  updateProperty({required String? name}) {
    _name = name ?? "Default";

    notifyListeners();
  }
}

class FlutterPackage extends StatelessWidget {
  const FlutterPackage({Key? key, this.name}) : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: Child(
      name: name,
    ));
  }
}

class Child extends ConsumerStatefulWidget {
  const Child({Key? key, this.name}) : super(key: key);

  final String? name;

  @override
  ConsumerState<Child> createState() => _ChildState();
}

class _ChildState extends ConsumerState<Child> {
  @override
  void initState() {
    ref.read(stateProvider).initialiseProperty(name: widget.name);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Child oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stateProvider).updateProperty(name: widget.name);
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return const ShowName();
  }
}

class ShowName extends ConsumerWidget {
  const ShowName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Text(ref.watch(stateProvider).name);
          },
        ),
      ),
    );
  }
}
