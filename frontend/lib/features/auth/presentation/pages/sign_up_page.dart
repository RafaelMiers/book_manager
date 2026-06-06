import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/stacks_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms to continue.')),
      );
      return;
    }
    context.read<AuthBloc>().add(AuthSignUpRequested(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          confirmPassword: _confirmController.text,
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
                  const SizedBox(height: 16),

                  // Back + inline logo
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: theme.colorScheme.outline),
                        ),
                        child: Center(
                          child: Text('logo', style: theme.textTheme.labelSmall?.copyWith(fontSize: 7)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('stacks', style: theme.textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: 28),

                  Text('Create your account', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text('Start building your library today', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 24),

                  StacksTextField(
                    label: 'Full name',
                    controller: _nameController,
                    hint: 'Alex Costa',
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 12),

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
                        (v == null || v.length < 8) ? 'Min. 8 characters' : null,
                  ),
                  const SizedBox(height: 12),

                  // Confirm password with live match indicator
                  ValueListenableBuilder(
                    valueListenable: _passwordController,
                    builder: (_, __, ___) {
                      final matches = _confirmController.text == _passwordController.text &&
                          _confirmController.text.isNotEmpty;
                      return StacksTextField(
                        label: 'Confirm password',
                        controller: _confirmController,
                        obscureText: true,
                        suffix: matches
                            ? Icon(Icons.check, size: 16, color: theme.colorScheme.secondary)
                            : null,
                        validator: (v) =>
                            v != _passwordController.text ? 'Passwords do not match' : null,
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Terms checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text.rich(
                            TextSpan(
                              style: theme.textTheme.labelMedium,
                              children: [
                                const TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(color: theme.colorScheme.primary),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: theme.colorScheme.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

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
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('Create account'),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

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
                    label: const Text('Sign up with Google'),
                  ),
                  const SizedBox(height: 24),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ', style: theme.textTheme.bodySmall),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Sign in'),
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
