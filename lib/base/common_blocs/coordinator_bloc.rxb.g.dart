// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'coordinator_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class CoordinatorBlocType extends RxBlocTypeBase {
  CoordinatorEvents get events;
  CoordinatorStates get states;
}

/// [$CoordinatorBloc] extended by the [CoordinatorBloc]
/// {@nodoc}
abstract class $CoordinatorBloc extends RxBlocBase
    implements CoordinatorEvents, CoordinatorStates, CoordinatorBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [noteUpdated]
  final _$noteUpdatedEvent = PublishSubject<Note>();

  /// Тhe [Subject] where events sink to by calling
  /// [notesWithExtraDetailsFetched]
  final _$notesWithExtraDetailsFetchedEvent = PublishSubject<List<Note>>();

  /// The state of [onNotesUpdated] implemented in [_mapToOnNotesUpdatedState]
  late final Stream<List<Note>> _onNotesUpdatedState =
      _mapToOnNotesUpdatedState();

  @override
  void noteUpdated(Note note) => _$noteUpdatedEvent.add(note);

  @override
  void notesWithExtraDetailsFetched(List<Note> notes) =>
      _$notesWithExtraDetailsFetchedEvent.add(notes);

  @override
  Stream<List<Note>> get onNotesUpdated => _onNotesUpdatedState;

  Stream<List<Note>> _mapToOnNotesUpdatedState();

  @override
  CoordinatorEvents get events => this;

  @override
  CoordinatorStates get states => this;

  @override
  void dispose() {
    _$noteUpdatedEvent.close();
    _$notesWithExtraDetailsFetchedEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
