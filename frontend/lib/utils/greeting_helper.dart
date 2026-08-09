class GreetingHelper {
  GreetingHelper._();

  /// Returns the appropriate greeting prefix based on the local time of day:
  /// - 5:00 AM to 11:59 AM: 'Good Morning'
  /// - 12:00 PM to 4:59 PM: 'Good Afternoon'
  /// - 5:00 PM to 8:59 PM: 'Good Evening'
  /// - 9:00 PM to 4:59 AM: 'Good Night'
  static String getGreetingPrefix({DateTime? dateTime}) {
    final now = dateTime ?? DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  /// Returns the complete combined greeting string e.g. "Good Morning, Ziyan"
  static String getFullGreeting({String? name, DateTime? dateTime}) {
    final prefix = getGreetingPrefix(dateTime: dateTime);
    final displayName = (name != null && name.trim().isNotEmpty) ? name.trim() : 'Student';
    return '$prefix, $displayName';
  }
}
