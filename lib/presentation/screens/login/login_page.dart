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
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthenticationState>(
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
                return Center(
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Icon(
                              Icons.school,
                              size: MediaQuery.of(context).size.width * 0.3,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              "DEUCEPTE",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 20),
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
                                hintStyle:
                                    const TextStyle(color: Colors.black38),
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
                                hintStyle:
                                    const TextStyle(color: Colors.black38),
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
                                onPressed: () => context
                                    .read<AuthCubit>()
                                    .login(usernameController.text,
                                        passwordController.text),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  child: Text(
                                    'Giriş yap'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            if (state.error ==
                                AuthenticationError.wrongpassword)
                              const Text('Kullanıcı adı veya parola hatalı!')
                            else if (state.error ==
                                AuthenticationError.connectionerror)
                              const Text('Bağlantı hatası!')
                          ],
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.centerRight,
        height: MediaQuery.of(context).size.height * 0.1,
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        child: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            showDialog<AlertDialog>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Hakkında'),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Bu uygulama Deucepte\'nin resmi uygulaması değildir. Deucepte\'ye giriş yapmak için kullanıcı adı ve parolanızı kullanmanız gerekmektedir. Uygulama geliştiricisi Dokuz Eylül Üniversitesi\'ne bağlı değildir.',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'DEUCEPTE ' +
                                packageInfo.version +
                                "(${packageInfo.buildNumber})",
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Tamam'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
