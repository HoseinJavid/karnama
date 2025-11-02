part of 'selection_theme_bloc.dart';

@immutable
sealed class SelectionThemeState {}

final class SelectionThemeInitial extends SelectionThemeState {
}

final class ThemeConfigLoaded extends SelectionThemeState{
  final String themeIdentifer;

  ThemeConfigLoaded({required this.themeIdentifer});

}