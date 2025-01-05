enum FilterList { now_playing, upcoming, top_rated, popular }

extension FilterListExtension on FilterList {
  String get name {
    switch (this) {
      case FilterList.now_playing:
        // TODO: Handle this case.
        return 'Now Playing';
      case FilterList.upcoming:
        // TODO: Handle this case.
        return 'Upcoming';
      case FilterList.top_rated:
        // TODO: Handle this case.
        return 'Top Rated';
      case FilterList.popular:
        // TODO: Handle this case.
        return 'Popular';
    }
  }

  String get value {
    switch (this) {
      case FilterList.now_playing:
        // TODO: Handle this case.
        return 'now_playing';
      case FilterList.upcoming:
        // TODO: Handle this case.
        return 'upcoming';
      case FilterList.top_rated:
        // TODO: Handle this case.
        return 'top_rated';
      case FilterList.popular:
        // TODO: Handle this case.
        return 'popular';
    }
  }
}
