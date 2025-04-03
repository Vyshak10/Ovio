import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:healthcare/services/period_storage_service.dart';

void main() {
  runApp(const MaterialApp(
    home: CalendarScreen(),
  ));
}

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final PageController _pageController = PageController(initialPage: 100);
  final List<DateTime> _displayedDates = [];
  final int _daysToShow = 7;
  int _currentCenterIndex = 100;

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    final today = DateTime.now();
    for (int i = -100; i <= 100; i++) {
      _displayedDates.add(today.add(Duration(days: i)));
    }
  }

  void _loadMoreDates(bool loadPrevious) {
    setState(() {
      if (loadPrevious) {
        final firstDate = _displayedDates.first;
        for (int i = 1; i <= 30; i++) {
          _displayedDates.insert(0, firstDate.subtract(Duration(days: i)));
        }
        _currentCenterIndex += 30;
      } else {
        final lastDate = _displayedDates.last;
        for (int i = 1; i <= 30; i++) {
          _displayedDates.add(lastDate.add(Duration(days: i)));
        }
      }
    });
  }

  String _getWeekdayAbbreviation(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
      case 7:
        return 'S';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Period Tracker'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/img/Frame.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 80,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification) {
                          final page = _pageController.page?.round() ??
                              _currentCenterIndex;
                          if (page <= 10) {
                            _loadMoreDates(true);
                            _pageController.jumpToPage(page + 30);
                          } else if (page >=
                              _displayedDates.length ~/ _daysToShow - 10) {
                            _loadMoreDates(false);
                          }
                        }
                        return false;
                      },
                      child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: _displayedDates.length ~/ _daysToShow,
                        onPageChanged: (index) {
                          setState(() {
                            _currentCenterIndex = index;
                          });
                        },
                        itemBuilder: (context, pageIndex) {
                          final startIndex = pageIndex * _daysToShow;
                          final endIndex = startIndex + _daysToShow;
                          final datesToShow = _displayedDates.sublist(
                            startIndex,
                            endIndex < _displayedDates.length
                                ? endIndex
                                : _displayedDates.length,
                          );

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: datesToShow.map((date) {
                              final day = date.day.toString();
                              final weekday = _getWeekdayAbbreviation(date);
                              final isToday = isSameDay(date, DateTime.now());

                              return isToday
                                  ? _TodayHeader(day: day, weekday: 'TODAY')
                                  : _DayHeader(day: day, weekday: weekday);
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'Period',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE91E63),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Day 1',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PeriodCalendarScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        foregroundColor: const Color(0xFFE91E63),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text(
                        'Edit period dates',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayHeader extends StatelessWidget {
  final String day;
  final String weekday;

  const _DayHeader({required this.day, required this.weekday, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weekday,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            day,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayHeader extends StatelessWidget {
  final String day;
  final String weekday;

  const _TodayHeader({required this.day, required this.weekday, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weekday,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            day,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class PeriodCalendarScreen extends StatefulWidget {
  const PeriodCalendarScreen({super.key});

  @override
  State<PeriodCalendarScreen> createState() => _PeriodCalendarScreenState();
}

class _PeriodCalendarScreenState extends State<PeriodCalendarScreen> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  final Set<DateTime> _markedDates = {};
  final PageController _pageController = PageController(initialPage: 1);
  final List<DateTime> _monthPages = [];
  int _currentPage = 1;
  final PeriodStorageService _storageService = PeriodStorageService();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = now;
    _selectedDay = now;
    _initializeMonthPages();
    _loadSavedDates();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedDates() async {
    try {
      final savedDates = await _storageService.loadPeriodDates();
      if (mounted) {
        setState(() {
          _markedDates.clear();
          _markedDates.addAll(savedDates);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error loading saved dates')),
        );
      }
    }
  }

  void _initializeMonthPages() {
    final now = DateTime.now();
    _monthPages.clear();
    _monthPages.addAll([
      DateTime(now.year, now.month - 1, 1),
      DateTime(now.year, now.month, 1),
      DateTime(now.year, now.month + 1, 1),
    ]);
  }

  Future<void> _loadMoreMonths(bool loadPrevious) async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    setState(() {
      if (loadPrevious) {
        final firstMonth = _monthPages.first;
        _monthPages.insert(
            0, DateTime(firstMonth.year, firstMonth.month - 1, 1));
        _currentPage += 1;
      } else {
        final lastMonth = _monthPages.last;
        _monthPages.add(DateTime(lastMonth.year, lastMonth.month + 1, 1));
      }
    });

    _isLoadingMore = false;
  }

  Future<void> _showStoredDates() async {
    try {
      final datesString = await _storageService.getDatesAsString();
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Recorded Period Dates'),
          content: SingleChildScrollView(
            child: Text(datesString),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error loading dates')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: const Text('Mark Period Dates'),
        backgroundColor: const Color(0xFFFCE4EC),
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _showStoredDates,
            tooltip: 'View recorded dates',
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              await _storageService.savePeriodDates(_markedDates);
              Navigator.pop(context, _markedDates);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  final page = _pageController.page?.round() ?? _currentPage;
                  if (page <= 1 && !_isLoadingMore) {
                    _loadMoreMonths(true);
                  } else if (page >= _monthPages.length - 2 &&
                      !_isLoadingMore) {
                    _loadMoreMonths(false);
                  }
                  _currentPage = page;
                }
                return false;
              },
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: _monthPages.length,
                onPageChanged: (index) {
                  setState(() {
                    _focusedDay = _monthPages[index];
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    color: const Color(0xFFFCE4EC),
                    child: TableCalendar(
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2050),
                      focusedDay: _monthPages[index],
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          if (_markedDates.contains(selectedDay)) {
                            _markedDates.remove(selectedDay);
                          } else {
                            _markedDates.add(selectedDay);
                          }
                        });
                      },
                      calendarStyle: CalendarStyle(
                        defaultDecoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.rectangle,
                        ),
                        weekendDecoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.rectangle,
                        ),
                        outsideDecoration: const BoxDecoration(
                          color: Color(0xFFF8BBD0),
                          shape: BoxShape.rectangle,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Color(0xFFE91E63),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: const Color(0xFFF8BBD0),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFE91E63),
                            width: 2,
                          ),
                        ),
                        weekendTextStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        defaultTextStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        leftChevronIcon:
                            Icon(Icons.chevron_left, color: Colors.black),
                        rightChevronIcon:
                            Icon(Icons.chevron_right, color: Colors.black),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.black),
                        weekendStyle: TextStyle(color: Colors.black),
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, date, events) {
                          if (_markedDates.contains(date)) {
                            return Positioned(
                              right: 1,
                              bottom: 1,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE91E63),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Tap on dates to mark/unmark period days',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await _storageService.savePeriodDates(_markedDates);
                    Navigator.pop(context, _markedDates);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Save Period Dates',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
