#!/usr/bin/env sh

mkdir -p android-data
adb shell run-as app.jishostudytool.jisho_study_tool cat app_flutter/jisho.sqlite > android-data/jisho_extract.db