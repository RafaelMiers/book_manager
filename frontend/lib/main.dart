import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/api_client.dart';
import 'core/theme/stacks_theme.dart';
import 'core/utils/secure_storage.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_out_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';
import 'features/library/data/datasources/library_remote_datasource.dart';
import 'features/library/data/repositories/library_repository_impl.dart';
import 'features/library/domain/usecases/get_library_usecase.dart';
import 'features/library/presentation/bloc/library_bloc.dart';
import 'features/library/presentation/pages/library_page.dart';

void main() {
  runApp(const StacksApp());
}

class StacksApp extends StatelessWidget {
  const StacksApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ── Singletons ──────────────────────────────────
    final apiClient = ApiClient(baseUrl: '54.207.65.184:8000');
    final secureStorage = SecureStorage();

    final authRemote = AuthRemoteDataSourceImpl(apiClient);
    final authRepo = AuthRepositoryImpl(
      remoteDataSource: authRemote,
      secureStorage: secureStorage,
      apiClient: apiClient,
    );

    final libraryRemote = LibraryRemoteDataSourceImpl(apiClient);
    final libraryRepo = LibraryRepositoryImpl(libraryRemote);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            signIn: SignInUseCase(authRepo),
            signUp: SignUpUseCase(authRepo),
            signOut: SignOutUseCase(authRepo),
            repository: authRepo,
          )..add(const AuthCheckRequested()),
        ),
        BlocProvider(
          create: (_) => LibraryBloc(
            getRecent: GetRecentBooksUseCase(libraryRepo),
            getUnopened: GetUnopenedBooksUseCase(libraryRepo),
            getAll: GetAllBooksUseCase(libraryRepo),
            getCollections: GetCollectionsUseCase(libraryRepo),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Stacks',
        debugShowCheckedModeBanner: false,
        theme: StacksTheme.dark,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return LibraryPage(user: state.user);
            }
            return const SignInPage();
          },
        ),
      ),
    );
  }
}
