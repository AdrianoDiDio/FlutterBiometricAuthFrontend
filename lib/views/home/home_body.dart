import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/auth_repository.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/user_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/user_response.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:biometric_auth_frontend/views/login/login_view.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoProvider = FutureProvider.autoDispose((ref) async {
  UserRepositoryImplementation userRepositoryImplementation =
      UserRepositoryImplementation();
  logger.d("Future provider launched...awaiting results");
  Either<Failure, UserResponse> result =
      await userRepositoryImplementation.getUserDetails();
  return result;
});

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  void _logout(BuildContext context) async {
    StorageUtils storageUtils = StorageUtils();
    String? refreshToken = await storageUtils.read(StorageKeys.refreshToken);
    if (refreshToken != null) {
      AuthRepositoryImplementation authRepository =
          AuthRepositoryImplementation();
      Either<Failure, bool> result =
          await authRepository.logout(refreshToken).whenComplete(() {
        StorageUtils storageUtils = StorageUtils();
        storageUtils.delete(StorageKeys.accessToken);
        storageUtils.delete(StorageKeys.refreshToken);
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
    return SafeArea(
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
                                ErrorObject.mapFailureToErrorObject(failure: l);
                            logger.d("Error....${errorObject.message}");
                            Future.microtask(() =>
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName));
                            return Container();
                          }, (r) {
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
                                          S.of(context).homeScreenUserInfoTitle,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      8,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        const CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              initialValue: r.username,
                                              readOnly: true,
                                              decoration: const InputDecoration(
                                                  labelText: "Username"),
                                            ),
                                            SizedBox(
                                                height: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5),
                                            TextFormField(
                                              initialValue: r.email,
                                              readOnly: true,
                                              decoration: const InputDecoration(
                                                  labelText: "Email"),
                                            ),
                                            SizedBox(
                                                height: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5),
                                            TextFormField(
                                              initialValue: r.id.toString(),
                                              readOnly: true,
                                              decoration: const InputDecoration(
                                                  labelText: "Id"),
                                            ),
                                            SizedBox(
                                                height: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3),
                                          ],
                                        )),
                                    ElevatedButton(
                                      child: Text(
                                          S.of(context).logoutButtonTextEntry),
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
                          Future.microtask(() => Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName));

                          return Container();
                        }))
                  ],
                ))));
  }
}
