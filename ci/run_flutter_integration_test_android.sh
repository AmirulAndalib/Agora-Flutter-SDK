#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

source ${MY_PATH}/../scripts/artifacts_version.sh

bash ${MY_PATH}/../scripts/download_unzip_iris_cdn_artifacts.sh ${IRIS_CDN_URL_ANDROID} "Android"

pushd ${MY_PATH}/../test_shard/fake_test_app

flutter packages get

flutter test integration_test

popd

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

flutter build macos --dart-define=TEST_APP_ID="${TEST_APP_ID}" lib/fake_remote_user_main.dart
open build/macos/Build/Products/Release/integration_test_app.app

flutter test integration_test --dart-define=TEST_APP_ID="${TEST_APP_ID}"

popd