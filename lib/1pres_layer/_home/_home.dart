import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_layer/isloading/isloading.dart';

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider((ref) => 0);

class SidebarHome extends ConsumerWidget {
  const SidebarHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home page')),
      body: homeBody(ref),
    );
  }

  Widget homeBody(ref) {
    return Column(
      children: [
        isloadingListTile(),
      ],
    );
  }
}
