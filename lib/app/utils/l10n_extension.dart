import 'import.dart';

extension ContextLoc on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
