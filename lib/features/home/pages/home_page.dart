import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/router.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/data/content_data.dart';
import '../../../shared/data/mock_data.dart';
import '../../drawer/app_drawer.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/horizontal_content_section.dart';
import '../widgets/promo_cards.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/story_circles.dart';
import '../widgets/weather_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadCountProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: const AppDrawer(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context, unread),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
                      child: WeatherWidget(),
                    ),
                    BannerCarousel(items: MockData.banners),
                    const SizedBox(height: 20),
                    const StoryCircles(),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Text(
                        AppStrings.quickActionsTitle,
                        style: AppTextStyles.sectionTitle,
                      ),
                    ),
                    const QuickActionsGrid(),
                    const SizedBox(height: 16),
                    const PromoCards(),
                    const SizedBox(height: 28),
                    HorizontalContentSection(
                      title: 'Güncel Haberler',
                      items: ContentData.news,
                    ),
                    const SizedBox(height: 24),
                    HorizontalContentSection(
                      title: 'Etkinlikler',
                      items: ContentData.events,
                    ),
                    const SizedBox(height: 24),
                    HorizontalContentSection(
                      title: 'Çekmeköy Akademi',
                      items: ContentData.courses,
                      showDate: false,
                    ),
                    const SizedBox(height: 24),
                    HorizontalContentSection(
                      title: 'Duyurular',
                      items: ContentData.announcements,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            const BottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, int unread) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 44),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () => AppRouter.open(context, '/notifications'),
                icon: const Icon(Icons.notifications_outlined),
              ),
              if (unread > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$unread',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Builder(
            builder: (ctx) => IconButton(
              onPressed: () => Scaffold.of(ctx).openEndDrawer(),
              icon: const Icon(Icons.menu),
            ),
          ),
        ],
      ),
    );
  }
}
