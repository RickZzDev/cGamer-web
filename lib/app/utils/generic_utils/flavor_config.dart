import 'package:flutter_flavor/flutter_flavor.dart';

abstract class FlavorConfigUtils {
  static createProdConfig() => FlavorConfig(
        name: "PROD",
        variables: {
          "baseUrl": "api.joggabank.com.br",
        },
      );

  static createDevConfig() => FlavorConfig(
        name: "DEV",
        variables: {
          "baseUrl": "alb-qa-bancogamer-2026716548.us-east-1.elb.amazonaws.com",
        },
      );
}
