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
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
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
                    return Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: usernameController,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Kullanıcı adı',
                                hintStyle:
                                    const TextStyle(color: Colors.black38),
                                contentPadding: const EdgeInsets.all(15.0),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: passwordController,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Parola',
                                      hintStyle: const TextStyle(
                                          color: Colors.black38),
                                      contentPadding:
                                          const EdgeInsets.all(15.0),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                    obscureText: !showPassword.value,
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: IconButton(
                                    icon: Icon(showPassword.value
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined),
                                    color: Colors.black,
                                    onPressed: () => showPassword.value =
                                        !showPassword.value,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
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
                          else
                            const Text('@ogr.deu.edu.tr olmadan giriş yapınız!')
                        ],
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
