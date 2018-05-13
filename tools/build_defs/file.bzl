def basename(path):
  return [component for component in path.split("/") if component][-1]

def replace_extension(path, ext):
  path, _, _ = path.rpartition(".")
  return path + "." + ext

def copy(name, srcs, dest=None, dir=None, **kwargs):
  if (dest == None) == (dir == None):
    fail("exactly one of dest and dir should be specifified")
  if type(srcs) == "string":
    srcs = [srcs]
  if dest != None:
    if len(srcs) != 1:
      fail("When dest is specified, srcs must be a single file", attr="srcs")
    if dest.endswith("/"):
      fail("dest can only be a file", attr="dest")
    outs = [dest]
  else:
    if not dir.endswith("/"):
      dir += "/"
    outs = [dir + basename(src) for src in srcs]
  if len(outs) == 1:
    dest_arg = "$@"
  else:
    dest_arg = "$(@D)/" + dir
  native.genrule(
      name = name,
      srcs = srcs,
      outs = outs,
      tools = [
          "@bazel_shared//tools/build_defs:copy_sh",
      ],
      cmd = "$(location @bazel_shared//tools/build_defs:copy_sh) " +
            "'%s' $(SRCS)" % dest_arg,
      **kwargs
  )
