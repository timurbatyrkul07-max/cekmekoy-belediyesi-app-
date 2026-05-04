import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/preferences_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/pages/home_page.dart';
import '../pages/onboarding_page.dart';
import 'kvkk_sheet.dart';

class AppGate extends ConsumerStatefulWidget {
  const AppGate({super.key});

  @override
  ConsumerState<AppGate> createState() => _AppGateState();
}

class _AppGateState extends ConsumerState<AppGate> {
  bool _kvkkSheetShown = false;

  @override
  Widget build(BuildContext context) {
    final start = ref.watch(appStartProvider);

    return start.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Hata: $e')),
      ),
      data: (state) {
        if (!state.onboardingCompleted) {
          return const OnboardingPage();
        }
        if (!state.kvkkAccepted && !_kvkkSheetShown) {
          _kvkkSheetShown = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) KvkkSheet.show(context);
          });
        }
        return const HomePage();
      },
    );
  }
}
