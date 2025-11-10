part of 'selection_theme_bloc.dart';

@immutable
sealed class SelectionThemeState {}

final class SelectionThemeInitial extends SelectionThemeState {
}

final class ThemeConfigLoaded extends SelectionThemeState{
  final String themeIdentifer;
  final String languageCode;

  ThemeConfigLoaded({required this.themeIdentifer,required this.languageCode});

}