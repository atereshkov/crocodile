#!/bin/bash

flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/generated/localization lib/app/localization/app_localizations.dart
