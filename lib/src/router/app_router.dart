import 'package:go_router/go_router.dart';
import '../../app/presentation/pages/splash_page.dart';
import '../../app/presentation/pages/cats_page.dart';
import '../../app/presentation/pages/cat_detail_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String cats = '/cats';
  static const String catDetail = '/cat-detail';

  static GoRouter get router => GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashPage()),
      GoRoute(path: cats, builder: (context, state) => const CatsPage()),
      GoRoute(
        path: '$catDetail/:id',
        builder: (context, state) {
          final catId = state.pathParameters['id']!;
          return CatDetailPage(catId: catId);
        },
      ),
    ],
  );
}
