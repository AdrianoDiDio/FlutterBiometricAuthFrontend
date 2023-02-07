import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/user_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/user_response.dart';
import 'package:biometric_auth_frontend/size_config.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userValue = ref.watch(userInfoProvider);
    return RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userInfoProvider);
        },
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: userValue.when(data: (item) {
              return item.fold((l) {
                ErrorObject errorObject =
                    ErrorObject.mapFailureToErrorObject(failure: l);
                logger.d("Error....${errorObject.message}");
                Future.microtask(() => Navigator.pushReplacementNamed(
                    context, LoginScreen.routeName));
                return Container();
              }, (r) {
                return SafeArea(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 8,
                          horizontal: SizeConfig.blockSizeHorizontal * 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text("User Info",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 8,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("Id ${r.id}"),
                            Text("Email ${r.email}"),
                            Text("Username ${r.username}"),
                          ],
                        ),
                      )),
                );
              });
            }, loading: () {
              logger.d("Loading");
              return const Center(child: CircularProgressIndicator());
            }, error: (e, st) {
              logger.d("Unexpected error...");
              Future.microtask(() => Navigator.pushReplacementNamed(
                  context, LoginScreen.routeName));

              return Container();
            })));
  }
}
