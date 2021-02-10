class Utilities {
  static String formatStats(int statCount) {
    if (statCount < 10000) {
      return statCount.toString();
    } else if (statCount >= 10000 && statCount < 1000000) {
      double statDouble = (statCount.toDouble() / 1000);
      String statString = statDouble.toStringAsFixed(1) + 'K';
      return statString;
    } else if (statCount >= 1000000 && statCount < 1000000000) {
      double statDouble = (statCount.toDouble() / 1000000);
      String statString = statDouble.toStringAsFixed(1) + 'M';
      return statString;
    } else if (statCount >= 1000000000) {
      double statDouble = (statCount.toDouble() / 1000000000);
      String statString = statDouble.toStringAsFixed(1) + 'B';
      return statString;
    }
    return null;
  }

  static String formatTime({DateTime createdOn}) {
    DateTime present = DateTime.now();
    Map<String, int> timePassed = {
      'year': (present.year - createdOn.year),
      'month': (present.month - createdOn.month),
      'day': (present.day - createdOn.day),
      'hour': (present.hour - createdOn.hour),
      'minute': (present.minute - createdOn.minute),
      'second': (present.second - createdOn.second),
    };
    if (timePassed['year'] > 0) {
      return '${timePassed["year"]} year ago';
    } else if (timePassed['month'] > 0) {
      return '${timePassed["month"]} months ago';
    } else if (timePassed['day'] > 0) {
      return '${timePassed["day"]} days ago';
    } else if (timePassed['hour'] > 0) {
      return '${timePassed["hour"]} hours ago';
    } else if (timePassed['minute'] > 0) {
      return '${timePassed["minute"]} minutes ago';
    } else if (timePassed['second'] > 0) {
      return '${timePassed["second"]} seconds ago';
    }
    return '';
  }
}
