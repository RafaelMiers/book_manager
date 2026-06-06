import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/stacks_text_field.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthBloc>().add(AuthSignInRequested(
          email: _emailController.text,
          password: _passwordController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Logo placeholder
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.outline,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'logo',
                              style: theme.textTheme.labelSmall,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text('stacks', style: theme.textTheme.headlineMedium),
                        const SizedBox(height: 2),
                        Text(
                          'your personal library',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  Text('Welcome back', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text('Sign in to access your library', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 24),

                  StacksTextField(
                    label: 'Email',
                    controller: _emailController,
                    hint: 'you@email.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                  ),
                  const SizedBox(height: 12),

                  StacksTextField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Enter your password' : null,
                  ),
                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  const SizedBox(height: 8),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final loading = state is AuthLoading;
                      return ElevatedButton(
                        onPressed: loading ? null : _submit,
                        child: loading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Sign in'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('or', style: theme.textTheme.labelMedium),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),

                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata, size: 20),
                    label: const Text('Continue with Google'),
                  ),
                  const SizedBox(height: 32),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No account? ", style: theme.textTheme.bodySmall),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SignUpPage()),
                          ),
                          child: const Text('Create one'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
