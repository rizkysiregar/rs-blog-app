import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_blog_app/core/secrets/app_secrets.dart';
import 'package:rs_blog_app/core/theme/theme.dart';
import 'package:rs_blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rs_blog_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:rs_blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:rs_blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:rs_blog_app/feature/auth/presentation/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  //runApp(const MyApp());
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => AuthBloc(
        userSignUp: UserSignUp(
          AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(supabaseClient: supabase.client),
          ),
        ),
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: AppTheme.darkThemeMode,
        home: const SignUpPage());
  }
}
