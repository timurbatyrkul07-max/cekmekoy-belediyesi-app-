import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/data/content_data.dart';
import '../../../shared/models/content_item.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../../shared/widgets/content_detail_page.dart';

class EventsCalendarPage extends StatefulWidget {
  const EventsCalendarPage({super.key});

  @override
  State<EventsCalendarPage> createState() => _EventsCalendarPageState();
}

class _EventsCalendarPageState extends State<EventsCalendarPage> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  CalendarFormat _format = CalendarFormat.month;

  late final Map<DateTime, List<ContentItem>> _eventsByDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _eventsByDay = {};
    for (final ev in ContentData.events) {
      final key = DateTime(ev.date.year, ev.date.month, ev.date.day);
      _eventsByDay.putIfAbsent(key, () => []).add(ev);
    }
  }

  List<ContentItem> _eventsForDay(DateTime day) {
    return _eventsByDay[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedDay ?? _focusedDay;
    final dayEvents = _eventsForDay(selected);

    return BrandedScaffold(
      title: 'Etkinlik Takvimi',
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TableCalendar<ContentItem>(
              firstDay: DateTime(2024, 1, 1),
              lastDay: DateTime(2027, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (d) => isSameDay(_selectedDay, d),
              calendarFormat: _format,
              locale: 'tr_TR',
              eventLoader: _eventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              onFormatChanged: (f) => setState(() => _format = f),
              onPageChanged: (focused) => _focusedDay = focused,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: AppTextStyles.bodyBold.copyWith(color: AppColors.primary),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                markerDecoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                markersMaxCount: 3,
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: AppTextStyles.h3,
                leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.primary),
                rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.primary),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
                weekendStyle: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          Expanded(
            child: dayEvents.isEmpty
                ? _empty(selected)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: dayEvents.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _EventTile(event: dayEvents[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _empty(DateTime day) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.event_busy, size: 56, color: AppColors.textTertiary),
          const SizedBox(height: 12),
          Text(
            DateFormat('d MMMM y', 'tr_TR').format(day),
            style: AppTextStyles.bodyBold,
          ),
          const SizedBox(height: 4),
          Text('Bu tarihte etkinlik yok',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final ContentItem event;
  const _EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ContentDetailPage(item: event)),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('HH:mm').format(event.date),
                    style: AppTextStyles.bodyBold.copyWith(color: AppColors.accent, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('d MMM', 'tr_TR').format(event.date),
                    style: AppTextStyles.caption.copyWith(color: AppColors.accent, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (event.category != null)
                    Text(
                      event.category!.toUpperCase(),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        letterSpacing: 0.5,
                      ),
                    ),
                  const SizedBox(height: 2),
                  Text(event.title, style: AppTextStyles.bodyBold),
                  if (event.location != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(event.location!,
                              style: AppTextStyles.caption,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
