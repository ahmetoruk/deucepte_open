import 'package:deucepte_open/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:deucepte_open/logic/cubits/auth/auth_cubit.dart';
import 'package:deucepte_open/presentation/screens/home_page/home_page.dart';
import 'package:deucepte_open/presentation/widgets/circle_progress_indicator.dart';

class LoginPage extends HookWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final showPassword = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş yap'),
      ),
      body: BlocConsumer<AuthCubit, AuthenticationState>(
        listener: (BuildContext context, AuthenticationState state) {
          if (state.status == AuthenticationStatus.authenticated) {
            Navigator.of(context).pushReplacement<dynamic, dynamic>(
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) => const MainPage(),
              ),
            );
          } else {
            usernameController.text = state.username;
            passwordController.text = state.password;
          }
        },
        builder: (BuildContext context, AuthenticationState state) {
          switch (state.status) {
            case AuthenticationStatus.authenticating:
              return const Center(
                child: CicleProgressIndicator(),
              );
            case AuthenticationStatus.authenticated:
              return Container();
            case AuthenticationStatus.unknown:
            case AuthenticationStatus.unauthenticated:
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'assets/images/logo_white.png',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'DEUCEPTE ' + packageInfo.version,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: usernameController,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.black38,
                            ),
                            hintText: 'Kullanıcı adı',
                            hintStyle: const TextStyle(color: Colors.black38),
                            contentPadding: const EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            suffix: const Text(
                              "@ogr.deu.edu.tr",
                              style: TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black38,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(showPassword.value
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined),
                              color: Colors.black,
                              onPressed: () =>
                                  showPassword.value = !showPassword.value,
                            ),
                            hintText: 'Parola',
                            hintStyle: const TextStyle(color: Colors.black38),
                            contentPadding: const EdgeInsets.all(15.0),
                            // rounded border

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          obscureText: !showPassword.value,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => context.read<AuthCubit>().login(
                                usernameController.text,
                                passwordController.text),
                            child: const Text('Giriş yap'),
                          ),
                        ),
                        if (state.error == AuthenticationError.wrongpassword)
                          const Text('Kullanıcı adı veya parola hatalı!')
                        else if (state.error ==
                            AuthenticationError.connectionerror)
                          const Text('Bağlantı hatası!')
                      ],
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
