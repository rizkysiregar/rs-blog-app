import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rs_blog_app/core/common/constants/route_constants.dart';
import 'package:rs_blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:rs_blog_app/core/theme/theme.dart';
import 'package:rs_blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:rs_blog_app/feature/auth/presentation/pages/login_page.dart';
import 'package:rs_blog_app/feature/auth/presentation/pages/signup_page.dart';
import 'package:rs_blog_app/feature/movie/presentation/bloc/movie_bloc.dart';
import 'package:rs_blog_app/feature/movie/presentation/home_page.dart';
import 'package:rs_blog_app/init_dependencies.dart';

//  ***  comment for video tracing **** //
//  last on : 3:45:55

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  //runApp(const MyApp());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<MovieBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// Go Router Configuration
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: RouteConstants.home,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/register',
      name: RouteConstants.register,
      builder: (context, state) {
        return const SignUpPage();
      },
    ),
    GoRoute(
      path: '/login',
      name: RouteConstants.login,
      builder: (context, state) {
        return const LoginPage();
      },
    ),
  ],
  redirect: (context, state) async {
    BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, isLoggedIn) {
        if (isLoggedIn) {
          return const HomePage();
        }
        return const SignUpPage();
      },
    );
    return null;
  },
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Movie app',
      theme: AppTheme.darkThemeMode,
      routerConfig: _router,
    );
  }
}
