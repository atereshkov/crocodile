#!/bin/bash

flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/generated/localization \ --no-use-deferred-loading lib/app/localization/app_localizations.dart lib/generated/localization/intl_*.arb
