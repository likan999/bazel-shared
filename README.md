This repository provides helper bazel functions that are shared by all bazel
related projects.

All bazel related projects should include the following in WORKSPACE file:

```python
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "bazel_shared",
    remote = "https://github.com/likan999/bazel-shared.git",
    tag = "latest",
)
```

Be sure to use the tag latest so that all project are using the same version of
this repository.
