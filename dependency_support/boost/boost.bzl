# Copyright 2020 The XLS Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Registers Bazel workspaces for the Boost C++ libraries."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def boost():
    maybe(
        git_repository,
        name = "com_github_nelhage_rules_boost",
        # This equivalent to boost 1.78
        commit = "c8b9b4a75c4301778d2e256b8d72ce47a6c9a1a4",
        remote = "https://github.com/nelhage/rules_boost",
        shallow_since = "1640124117 -0800",
        patches = [
            # rules_boost does not include Boost Python, see
            # https://github.com/nelhage/rules_boost/issues/67
            # This is because there doesn't exist a nice standard way in
            # Bazel to depend on the Python headers of the current Python
            # toolchain. The patch below selects the same Python headers
            # that the rest of XLS uses.
            Label("@rules_hdl//dependency_support/boost:add_python.patch"),
        ],
    )
