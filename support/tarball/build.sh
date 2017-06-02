#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_ROOT="$(cd -P "$( dirname "$0" )" && pwd)"
CLI_VERSION="2.0.0-preview2-006195"
PREBUILT_CLI_ROOT="$SCRIPT_ROOT/prebuilt/cli"
CLI_PATH="$PREBUILT_CLI_ROOT/$CLI_VERSION"

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1

MSBUILD_ARGUMENTS=("/p:OfflineBuild=true" "/flp:v=detailed" "/clp:v=detailed")

$CLI_PATH/dotnet $CLI_PATH/sdk/$CLI_VERSION/MSBuild.dll $SCRIPT_ROOT/build.proj /t:WriteDynamicPropsToStaticPropsFiles /p:GeneratingStaticPropertiesFile=true ${MSBUILD_ARGUMENTS[@]} "$@"
$CLI_PATH/dotnet $CLI_PATH/sdk/$CLI_VERSION/MSBuild.dll $SCRIPT_ROOT/build.proj ${MSBUILD_ARGUMENTS[@]} "$@"
