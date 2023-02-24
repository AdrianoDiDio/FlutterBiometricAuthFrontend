import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/auth_provider.dart';
import 'package:biometric_auth_frontend/providers/biometric_provider.dart';
import 'package:biometric_auth_frontend/repositories/auth_repository.dart';
import 'package:biometric_auth_frontend/repositories/user_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/user_response.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:biometric_auth_frontend/views/login/login_view.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' hide FutureProvider;

final userInfoProvider = FutureProvider.autoDispose((ref) async {
  UserRepositoryImplementation userRepositoryImplementation =
      UserRepositoryImplementation();
  logger.d("Future provider launched...awaiting results");
  Either<Failure, UserResponse> result =
      await userRepositoryImplementation.getUserDetails();
  return result;
});

class HomeView extends ConsumerWidget {
  static String routeName = "userInfo";
  static String routePath = "/home/userInfo";

  const HomeView({super.key});

  void _logout(BuildContext context) async {
    String? refreshToken =
        await serviceLocator.get<StorageUtils>().read(StorageKeys.refreshToken);
    if (refreshToken != null) {
      AuthRepositoryImplementation authRepository =
          AuthRepositoryImplementation();
      Either<Failure, bool> result =
          await authRepository.logout(refreshToken).whenComplete(() {
        Provider.of<AuthProvider>(context, listen: false).logout();
      });
      result.fold((l) {
        ErrorObject errorObject =
            ErrorObject.mapFailureToErrorObject(failure: l);
        logger.d("Error: ${errorObject.title} ${errorObject.message}");
      }, (r) {
        logger.d("Logout completed without any error...");
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userValue = ref.watch(userInfoProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).homeScreenUserInfoTitle),
        ),
        body: SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) => RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(userInfoProvider);
                    },
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                            hasScrollBody: false,
                            child: userValue.when(data: (item) {
                              return item.fold((l) {
                                ErrorObject errorObject =
                                    ErrorObject.mapFailureToErrorObject(
                                        failure: l);
                                logger.d("Error....${errorObject.message}");
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .logout();
                                });

                                return Container();
                              }, (r) {
                                _checkEnrolledBiometricsValidity(context, r);
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: constraints.maxHeight),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            ListTile(
                                                title: Text(
                                              S
                                                  .of(context)
                                                  .homeScreenUserInfoTitle,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      8,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            const CircleAvatar(
                                              child: Icon(Icons.person),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  initialValue: r.username,
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              "Username"),
                                                ),
                                                SizedBox(
                                                    height: SizeConfig
                                                            .blockSizeHorizontal *
                                                        5),
                                                TextFormField(
                                                  initialValue: r.email,
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: "Email"),
                                                ),
                                                SizedBox(
                                                    height: SizeConfig
                                                            .blockSizeHorizontal *
                                                        5),
                                                TextFormField(
                                                  initialValue: r.id.toString(),
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: "Id"),
                                                ),
                                                SizedBox(
                                                    height: SizeConfig
                                                            .blockSizeHorizontal *
                                                        3),
                                              ],
                                            )),
                                        ElevatedButton(
                                          child: Text(S
                                              .of(context)
                                              .logoutButtonTextEntry),
                                          onPressed: () {
                                            _logout(context);
                                          },
                                        ),
                                      ]),
                                );
                              });
                            }, loading: () {
                              logger.d("Loading");
                              return const Center(
                                  child: CircularProgressIndicator());
                            }, error: (e, st) {
                              logger.d("Unexpected error...");
                              Future.microtask(
                                  () => context.goNamed(LoginScreen.routeName));

                              return Container();
                            }))
                      ],
                    )))));
  }

  void _checkEnrolledBiometricsValidity(
      BuildContext context, UserResponse userResponse) async {
    String? biometricUserId = await serviceLocator
        .get<StorageUtils>()
        .read(StorageKeys.biometricsUserId);
    if (biometricUserId != null) {
      if (int.parse(biometricUserId) != userResponse.id) {
        logger.d("Enrollment was done by another user...cancelling it");
        if (context.mounted) {
          logger.d("Cancelling it...");
          Provider.of<BiometricProvider>(context, listen: false).cancel();
        }
      } else {
        logger.d("All ok");
      }
    }
  }
}
