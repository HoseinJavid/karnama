import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karnama/constant.dart';
import 'package:karnama/model/theme.dart';
import 'package:karnama/view/screens/selection_theme_screen/bloc/selection_theme_bloc.dart';

// a complete Flutter application demonstrating a theme selection screen
// inspired by the user's provided image (RTL layout for Persian).

/// The main screen displaying all theme options.
class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  // Mock state for selected theme
  // int selectedSolidColorIndex = 0;
  // int selectedLandscapeIndex = -1;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<SelectionThemeBloc, SelectionThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            // Custom header layout as seen in the image
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('تنظیم تم', style: TextStyle(fontSize: 18)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Section: Solid Colors  ---
                  _buildSectionHeader(title: 'رنگ خالص', theme: theme),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 70, // Height for the horizontal list
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: solidColorThemes.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final corentTheme =
                            solidColorThemes.values.toList()[index];
                        // final isSelected = index == selectedSolidColorIndex;
                        late final bool isSelected;
                        if (state is ThemeConfigLoaded) {
                          isSelected = corentTheme ==
                              solidColorThemes[state.themeIdentifer];
                        }
                        return GestureDetector(
                          onTap: () {
                            //ontap ---------------------------------------------
                            // setState(() {
                            // selectedSolidColorIndex = index;
                            // selectedLandscapeIndex = -1;
                            BlocProvider.of<SelectionThemeBloc>(context).add(
                                ChangeThemeEvent(
                                    themeIdentifer:
                                        corentTheme.themeIdentifer));
                            // });
                          },
                          child: _SolidColorItem(
                            theme: corentTheme,
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  // --- Section: solid image  ---
                  _buildSectionHeader(
                      title: 'منظره', isPremium: false, theme: theme),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.5, // Aspect ratio close to the image
                    ),
                    itemCount: landscapeThemes.length,
                    itemBuilder: (context, index) {
                      final corentTheme =
                          landscapeThemes.values.toList()[index];
                      // final isSelected = index == selectedLandscapeIndex;
                      late final bool isSelected;
                      if (state is ThemeConfigLoaded) {
                        isSelected = corentTheme ==
                            landscapeThemes[state.themeIdentifer];
                      }

                      return GestureDetector(
                        //ontap ---------------------------------------------
                        onTap: () {
                          setState(() {
                            // selectedSolidColorIndex = -1;
                            // selectedLandscapeIndex = index;
                            BlocProvider.of<SelectionThemeBloc>(context).add(
                                ChangeThemeEvent(
                                    themeIdentifer:
                                        corentTheme.themeIdentifer));
                          });
                        },
                        child: _LandscapeItem(
                            theme: corentTheme, isSelected: isSelected),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Helper widget for rendering section titles (RTL aligned).
  Widget _buildSectionHeader(
      {required String title,
      bool isPremium = false,
      required ThemeData theme}) {
    return Row(
      children: [
        if (isPremium) ...[
          const Icon(Icons.workspace_premium, color: Colors.amber, size: 18),
          const SizedBox(width: 4),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.brightness == Brightness.light
                ? Colors.black
                : Colors.white70,
          ),
        ),
      ],
    );
  }
}

// --- Custom Item Widgets ---
/// Widget for displaying a single solid color option.
class _SolidColorItem extends StatelessWidget {
  final SolidColorTheme theme;
  final bool isSelected;

  const _SolidColorItem({required this.theme, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: theme.myCustomAppTheme.primaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
          width: 3,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Selected checkmark icon
          if (isSelected)
            const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 30,
            ),
          // Premium crown icon
          if (theme.isPremium && !isSelected)
            const Positioned(
              top: 5,
              right: 5, // Top-right corner (RTL)
              child: Icon(
                Icons.workspace_premium,
                color: Colors.amber,
                size: 16,
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget for displaying a single landscape/wallpaper option.
class _LandscapeItem extends StatelessWidget {
  final LandscapeTheme theme;
  final bool isSelected;

  const _LandscapeItem({required this.theme, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    // Note: Using a placeholder text/color since external images cannot be loaded.
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
          width: 3,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Placeholder for the Image
          ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Image.asset(
                theme.imageUri,
                fit: BoxFit.fill,
              )),
          // New tag
          if (theme.isNew)
            const Positioned(
              top: 8,
              right: 8, // Top-right corner (RTL)
              child: _NewTag(),
            ),
          // Premium crown icon
          if (theme.isPremium)
            const Positioned(
              top: 8,
              left: 8, // Top-left corner (RTL)
              child: Icon(
                Icons.workspace_premium,
                color: Colors.amber,
                size: 20,
              ),
            ),
          // Selected checkmark icon overlay
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Icon(Icons.check_circle, color: Colors.white, size: 40),
              ),
            ),
        ],
      ),
    );
  }
}

/// Small red tag with  (New) text.
class _NewTag extends StatelessWidget {
  const _NewTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'جدید',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
