CPUS = [
    "arm",
    "arm64-v8a",
    "armeabi",
    "armeabi-v7a",
    "armv5",
    "armv7a",
    "darwin",
    "darwin_x86_64",
    "ios_i386",
    "ios_x86_64",
    "k8",
    "mips",
    "mips64",
    "piii",
    "s390x",
    "tvos_x86_64",
    "tvos_arm64",
    "watchos_armv7k",
    "watchos_i386",
    "x64_windows_msvc",
    "x64_windows_msys",
]

def _group(cpus, value):
    return {"@bazel_shared//tools/target_cpu:" + cpu: value for cpu in cpus}

def _group_startswith(prefix, value):
    return _group([cpu for cpu in CPUS if cpu.startswith(prefix)], value)

def _group_contains(needle, value):
    return _group([cpu for cpu in CPUS if cpu.find(needle) >= 0], value)

def arm(value):
    return _group_startswith("arm", value)

def darwin(value):
    return _group_startswith("darwin", value)

def ios(value):
    return _group_startswith("ios", value)

def mips(value):
    return _group_startswith("mips", value)

def tvos(value):
    return _group_startswith("tvos", value)

def watchos(value):
    return _group_startswith("watchos", value)

def windows(value):
    return _group_contains("windows", value)

def apple(value):
    return (darwin(value) + ios(value) + tvos(value) + watchos(value))

def linux(value):
    return _group(["k8", "piii"], value)

def x64(value):
    return (_group_contains("64", value) + _group(["k8", "s390x"], value))

def x86(value):
    return _group([cpu for cpu in CPUS if cpu not in x64(value)], value)

def big_endian(value):
    return _group(["s390x"], value)

def little_endian(value):
    return _group([cpu for cpu in CPUS if cpu != "s390x"], value)
