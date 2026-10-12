# Services

Cross-cutting logic: code generation, reports, theming, DI (`setupAppInjection`), and system errors.

Services do not replace repositories. Register them in `setupAppInjection()` and resolve them with `appInjection.get<T>()`.

Guide: [Code Generation](../CODE_GENERATOR_USAGE.md).
