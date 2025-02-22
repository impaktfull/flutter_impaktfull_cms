import 'package:flutter/material.dart';
import 'package:impaktfull_cms_example/screen/list_with_viewmodel_screen.dart';
import 'package:impaktfull_cms_example/screen/list_without_viewmodel_screen.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiScreen(
      title: 'Test app for the impatkfull_cms package',
      child: ImpaktfullUiListView(
        padding: const EdgeInsets.all(16),
        spacing: 8,
        children: [
          ImpaktfullUiButton(
            fullWidth: true,
            type: ImpaktfullUiButtonType.primary,
            title: 'List without viewmodel',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListWithoutViewmodelScreen(),
                ),
              );
            },
          ),
          ImpaktfullUiButton(
            fullWidth: true,
            type: ImpaktfullUiButtonType.primary,
            title: 'List with viewmodel',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListWithViewmodelScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
