import 'dart:async';

import 'package:notes_app/base/models/note.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'coordinator_bloc.rxb.g.dart';

// ignore: one_member_abstracts
abstract class CoordinatorEvents {
  void noteUpdated(Note note);

  void notesWithExtraDetailsFetched(List<Note> notes);
}

abstract class CoordinatorStates {
  @RxBlocIgnoreState()
  Stream<Note> get onNoteUpdated;

  @RxBlocIgnoreState()
  Stream<List<Note>> get onFetchedNotesWithExtraDetails;

  Stream<List<Note>> get onNotesUpdated;
}

/// The coordinator bloc manages the communication between blocs.
///
/// The goals is to keep all blocs decoupled from each other
/// as the entire communication flow goes through this bloc.
/// This way we ensure that we don't introduce a dependency hell.
@RxBloc()
class CoordinatorBloc extends $CoordinatorBloc {
  @override
  Stream<Note> get onNoteUpdated => _$noteUpdatedEvent;

  @override
  Stream<List<Note>> get onFetchedNotesWithExtraDetails =>
      _$notesWithExtraDetailsFetchedEvent;

  @override
  Stream<List<Note>> _mapToOnNotesUpdatedState() => Rx.merge([
        states.onNoteUpdated.map((note) => [note]),
        states.onFetchedNotesWithExtraDetails
      ]).share();
}
