#!/bin/bash
#
# Copyright 2015 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -euo pipefail

# Finds and returns the last -o parameter from a command line.
function get_output() {
  OUTPUT=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -o) shift; OUTPUT="$1"
    esac
    shift
  done
  echo "${OUTPUT}"
}

# Set-up the environment
%{env}

# Turn off '-e' and capture error codes from here on out.
set +e

# Call the C++ compiler
%{cc} "$@"

EXITCODE=$?

OUTPUT=$(get_output "$@")
if [[ "${OUTPUT}" == *.h.processed ]]; then
  echo -n > "${OUTPUT}"
fi

exit $EXITCODE
