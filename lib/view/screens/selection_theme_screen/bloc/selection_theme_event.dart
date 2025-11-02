part of 'selection_theme_bloc.dart';

@immutable
sealed class SelectionThemeEvent {}

class LoadInitialThemeEvent extends SelectionThemeEvent {}

class ChangeThemeEvent extends SelectionThemeEvent {
  final String themeIdentifer;

  ChangeThemeEvent({required this.themeIdentifer});
}
