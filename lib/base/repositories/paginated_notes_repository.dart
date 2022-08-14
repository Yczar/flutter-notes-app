import 'package:notes_app/base/models/note.dart';
import 'package:notes_app/base/repositories/notes_repository.dart';

class PaginatedNotesRepository implements NotesRepository {
  PaginatedNotesRepository(NotesRepository repository)
      : _repository = repository;
  final NotesRepository _repository;
  @override
  Future<Note> favoriteNote(Note note, {required bool isFavorite}) =>
      _repository.favoriteNote(note, isFavorite: isFavorite);

  @override
  Future<List<Note>> fetchFullEntities(List<String> ids,
          {bool allProps = false}) =>
      _repository.fetchFullEntities(
        ids,
        allProps: allProps,
      );

  @override
  Future<List<Note>> getFavoriteNotes() => _repository.getFavoriteNotes();

  @override
  Future<List<Note>> getNotes({filters}) =>
      _repository.getNotes(filters: filters);
}
