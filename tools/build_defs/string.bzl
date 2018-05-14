def strip_prefix(str, prefix, prompt="string"):
  if not str.startswith(prefix):
    fail("%s(%s) must start with %s" % (prompt.capitalize(), str, prefix))
  return str[len(prefix):]

def strip_suffix(str, suffix, prompt="string"):
  if not str.endswith(suffix):
    fail("%s(%s) must end with %s" % (prompt.capitalize(), str, suffix))
  return str[:-len(suffix)]
