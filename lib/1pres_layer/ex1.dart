import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../2app_layer/services/getdata.dart';
import '1widgets/rowdetailpage.dart';

// A Counter example implemented with riverpod

// void main() {
//   runApp(
//     // Adding ProviderScope enables Riverpod for the entire project
//     const ProviderScope(child: MyApp()),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider((ref) => 0);

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a widget that allows you reading providers.
        child: counterDisplay(ref),
      ),
      floatingActionButton: counterIncrement(ref, context),
    );
  }

  Widget counterIncrement(ref, BuildContext context) {
    return FloatingActionButton(
      // The read method is a utility to read a provider without listening to it
      onPressed: () async {
        ref.read(counterProvider.notifier).state++;
        await selectData();
        final values = await getSheetValues();
        Map rowMap = rowMapGet(values[0], values[1]);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RowmapDetailPage(rowMap)),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget counterDisplay(ref) {
    final count = ref.watch(counterProvider);
    return Consumer(
      builder: (context, ref, _) {
        return Text('$count');
      },
    );
  }
}
