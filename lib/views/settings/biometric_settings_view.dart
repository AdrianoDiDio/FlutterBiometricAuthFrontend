import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:flutter/material.dart';

class BiometricSettingsView extends StatefulWidget {
  static String routeName = "biometrics";
  static String routePath = "biometrics";

  const BiometricSettingsView({super.key});

  @override
  State<StatefulWidget> createState() {
    return BiometricSettingsViewState();
  }
}

class BiometricSettingsViewState extends State<BiometricSettingsView> {
  late bool _biometricStatus = false;

  void _init() async {
    String? biometricEnrolled = await serviceLocator
        .get<StorageUtils>()
        .read(StorageKeys.biometricsEnrolled);
    if (biometricEnrolled != null) {
      _biometricStatus = biometricEnrolled.toLowerCase() == 'true';
    } else {
      _biometricStatus = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).biometricsScreenTitle),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enable biometric authentication",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 3)),
                        Switch(
                          value: _biometricStatus,
                          onChanged: (value) {
                            if (!value) {
                              logger.d("Removing biometric data...");
                            } else {
                              logger.d("Starting on-board process");
                            }
                            setState(() {
                              _biometricStatus = !_biometricStatus;
                            });
                          },
                        )
                      ])
                ]))));
  }
}
