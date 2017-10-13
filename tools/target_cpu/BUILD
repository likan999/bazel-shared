package(default_visibility = ["//visibility:public"])

load("//tools/target_cpu:groups.bzl", "CPUS")

[
    config_setting(
        name = cpu,
        values = {
            "cpu": cpu,
        },
    )
    for cpu in CPUS
]
