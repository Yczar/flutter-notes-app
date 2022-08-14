import 'package:notes_app/base/models/note.dart';
import 'package:notes_app/base/repositories/connectivity/connectivity_repository.dart';

class NotesRepository {
  NotesRepository(
    ConnectivityRepository connectivityRepository, {
    int multiplier = 200,
  })  : _connectivityRepository = connectivityRepository,
        _notes = _generateEntities(
          multiplier: multiplier,
        );

  /// Simulate delays of the API http requests
  final _artificialDelay = const Duration(milliseconds: 300);
  final _noInternetConnectionErrorString =
      'No internet connection. Please check your settings.';

  final ConnectivityRepository _connectivityRepository;
  final List<Note> _notes;

  Future<Note> favoriteNote(
    Note note, {
    required bool isFavorite,
  }) async {
    await Future.delayed(_artificialDelay);

    if (!(await _connectivityRepository.isConnected())) {
      throw Exception(_noInternetConnectionErrorString);
    }

    final foundNote = _notes.firstWhere(
      (item) => item.id == note.id,
    );

    foundNote.isFavorite = isFavorite;

    return foundNote;
  }

  Future<List<Note>> fetchFullEntities(
    List<String> ids, {
    bool allProps = false,
  }) async {
    await Future.delayed(_artificialDelay);

    if (!(await _connectivityRepository.isConnected())) {
      throw Exception(_noInternetConnectionErrorString);
    }

    final notesWithExtraData = _notes
        .where((element) => ids.contains(element.id))
        .map((note) => note.copyWith(
              displayRating: note.rating,
              displaySubtitle: note.subTitle,
              displayReviews: note.reviews,
              displayDist: note.dist,
            ))
        .map((note) => allProps
            ? note.copyWith(
                displayDescription: note.description,
                displayFeatures: note.features,
              )
            : note)
        .toList();

    return notesWithExtraData;
  }

  Future<List<Note>> getNotes({NoteSearchFilters? filters}) async {
    if (!(await _connectivityRepository.isConnected())) {
      throw Exception(_noInternetConnectionErrorString);
    }

    await Future.delayed(_artificialDelay + Duration(milliseconds: 2000));

    final query = filters?.query ?? '';
    var copiedNotes = [..._notes];

    // If there are any other filters, apply them
    if (filters?.advancedFiltersOn ?? false) {
      copiedNotes = copiedNotes
          .where((note) => note.filtersApply(
                range: filters!.dateRange,
                rooms: filters.roomCapacity,
                persons: filters.personCapacity,
              ))
          .toList();
    }

    // Sort items before returning
    copiedNotes = _sortNotes(copiedNotes, filters?.sortBy ?? SortBy.none);

    if (query == '') {
      return copiedNotes;
    }

    return copiedNotes
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Note>> getFavoriteNotes() async {
    await Future.delayed(_artificialDelay);

    if (!(await _connectivityRepository.isConnected())) {
      throw Exception(_noInternetConnectionErrorString);
    }

    return _notes.where((note) => note.isFavorite).toList();
  }

  static List<Note> _generateEntities({required int multiplier}) => [];
}
