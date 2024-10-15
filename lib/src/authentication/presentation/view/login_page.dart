// import 'package:apac_e_commerce/core/utils/string_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../bloc/auth_bloc.dart';
// import '../bloc/auth_event.dart';
// import '../bloc/auth_state.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
//   final passwordRegex = RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
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
//                         // Trigger login only if form is valid
//                         context.read<AuthBloc>().add(
//                               AuthLoginRequested(
//                                 email: _emailController.text,
//                                 password: _passwordController.text,
//                               ),
//                             );
//                       }
//                     },
//                     child: const Text('Login'),
//                   );
//                 },
//               ),
//               TextButton(
//                 onPressed: () {
//                   context.pushNamed(StringConst.registerName);
//                   // Navigator.pushNamed(context, '/register');
//                 },
//                 child: const Text('Don\'t have an account? Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../core/utils/string_constants.dart';
// import '../bloc/auth_bloc.dart';
// import '../bloc/auth_event.dart';
// import '../bloc/auth_state.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   bool _isPasswordVisible = false;

//   final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
//   final passwordRegex = RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: const Text('Login'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Email Field
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(FontAwesomeIcons.envelope,
//                         color: Colors.teal),
//                     labelText: 'Email',
//                     labelStyle: TextStyle(color: Colors.teal),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide(color: Colors.teal),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide(color: Colors.teal),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     } else if (!emailRegex.hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 // Password Field
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: !_isPasswordVisible,
//                   decoration: InputDecoration(
//                     prefixIcon:
//                         const Icon(FontAwesomeIcons.lock, color: Colors.teal),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.teal,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                     labelText: 'Password',
//                     labelStyle: TextStyle(color: Colors.teal),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide(color: Colors.teal),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide(color: Colors.teal),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     } else if (!passwordRegex.hasMatch(value)) {
//                       return 'Password must include special character, a capital letter, and a numeric value';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24.0),
//                 // Login Button with BlocConsumer for state management
//                 BlocConsumer<AuthBloc, AuthState>(
//                   listener: (context, state) {
//                     if (state is AuthAuthenticated) {
//                       context.goNamed('/home');
//                     } else if (state is AuthError) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(state.errorMessage)),
//                       );
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is AuthLoading) {
//                       return const CircularProgressIndicator();
//                     }
//                     return ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           context.read<AuthBloc>().add(
//                                 AuthLoginRequested(
//                                   email: _emailController.text,
//                                   password: _passwordController.text,
//                                 ),
//                               );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16.0, horizontal: 100.0),
//                       ),
//                       child: const Text('Login',
//                           style: TextStyle(fontSize: 18, color: Colors.white)),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20.0),
//                 // Register Button
//                 TextButton(
//                   onPressed: () {
//                      context.pushNamed(StringConst.registerName);
//                   },
//                   child: const Text(
//                     'Don\'t have an account? Register',
//                     style: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/string_constants.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
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
        title: const Text(
          'Login',
        ),
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
                    labelStyle: TextStyle(color: Colors.teal),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.teal),
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
                        labelStyle: TextStyle(color: Colors.teal),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (!passwordRegex.hasMatch(value)) {
                          return 'Password must include special character, a capital letter, and a numeric value';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                // Login Button with BlocConsumer for state management
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
                                AuthLoginRequested(
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
                      child: const Text('Login',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                // Register Button
                TextButton(
                  onPressed: () {
                    context.pushNamed(StringConst.registerName);
                  },
                  child: const Text(
                    'Don\'t have an account? Register',
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
