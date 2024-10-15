// import 'package:apac_e_commerce/core/utils/string_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../bloc/auth_bloc.dart';
// import '../bloc/auth_event.dart';
// import '../bloc/auth_state.dart';

// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
//   final passwordRegex = RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey, // Form key for validation
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   } else if (!emailRegex.hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   } else if (!passwordRegex.hasMatch(value)) {
//                     return 'Password must include special character, a capital letter, and a numeric value';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               BlocConsumer<AuthBloc, AuthState>(
//                 listener: (context, state) {
//                   if (state is AuthAuthenticated) {
//                     context.goNamed(StringConst.productListingName);
//                   } else if (state is AuthError) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(state.errorMessage)),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is AuthLoading) {
//                     return const CircularProgressIndicator();
//                   }

//                   return ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         // Trigger registration only if form is valid
//                         context.read<AuthBloc>().add(
//                               AuthRegisterRequested(
//                                 email: _emailController.text,
//                                 password: _passwordController.text,
//                               ),
//                             );
//                       }
//                     },
//                     child: const Text('Register'),
//                   );
//                 },
//               ),
//               TextButton(
//                 onPressed: () {
//                   context.goNamed(StringConst.loginName);
//                 },
//                 child: const Text('Already have an account? Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:apac_e_commerce/core/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  final passwordRegex = RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$");

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(FontAwesomeIcons.envelope,
                        color: Colors.teal),
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.teal),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                // Password Field with Visibility Toggle
                ValueListenableBuilder(
                  valueListenable: _isPasswordVisible,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: !value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(FontAwesomeIcons.lock,
                            color: Colors.teal),
                        suffixIcon: IconButton(
                          icon: Icon(
                            value ? Icons.visibility : Icons.visibility_off,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            _isPasswordVisible.value =
                                !_isPasswordVisible.value;
                          },
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.teal),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.teal),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (!passwordRegex.hasMatch(value)) {
                          return 'Password must include a special character, a capital letter, and a numeric value';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                // Register Button with BlocConsumer for state management
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      context.goNamed(StringConst.productListingName);
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthRegisterRequested(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 100.0),
                      ),
                      child: const Text('Register',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                // Login Button
                TextButton(
                  onPressed: () {
                    context.goNamed(StringConst.loginName);
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
