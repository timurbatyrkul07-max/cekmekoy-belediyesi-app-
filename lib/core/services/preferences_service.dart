import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _onboardingKey = 'onboarding_completed';
  static const _kvkkKey = 'kvkk_accepted';

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  Future<bool> isKvkkAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kvkkKey) ?? false;
  }

  Future<void> setKvkkAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kvkkKey, true);
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
    await prefs.remove(_kvkkKey);
  }
}

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});

class AppStartState {
  final bool onboardingCompleted;
  final bool kvkkAccepted;

  const AppStartState({required this.onboardingCompleted, required this.kvkkAccepted});

  bool get isReady => onboardingCompleted && kvkkAccepted;
}

class AppStartNotifier extends AsyncNotifier<AppStartState> {
  @override
  Future<AppStartState> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return AppStartState(
      onboardingCompleted: await prefs.isOnboardingCompleted(),
      kvkkAccepted: await prefs.isKvkkAccepted(),
    );
  }

  Future<void> completeOnboarding() async {
    await ref.read(preferencesServiceProvider).setOnboardingCompleted();
    final current = state.value;
    state = AsyncValue.data(AppStartState(
      onboardingCompleted: true,
      kvkkAccepted: current?.kvkkAccepted ?? false,
    ));
  }

  Future<void> acceptKvkk() async {
    await ref.read(preferencesServiceProvider).setKvkkAccepted();
    final current = state.value;
    state = AsyncValue.data(AppStartState(
      onboardingCompleted: current?.onboardingCompleted ?? false,
      kvkkAccepted: true,
    ));
  }
}

final appStartProvider = AsyncNotifierProvider<AppStartNotifier, AppStartState>(
  AppStartNotifier.new,
);
