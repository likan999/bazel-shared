import argparse
import itertools
import string
import sys

FLAGS = argparse.Namespace()


def _check(cond, message):
    if not cond:
        sys.stderr.write(message)
        sys.exit(1)


def main(argv):
    parser = argparse.ArgumentParser(description="Template engine to generate config.h")
    parser.add_argument("--mappings", "-m", action="append", default=[], help="Mapping files containing lines VAR=VALUE")
    parser.add_argument("--aliases", "-a", action="append", default=[],
                        help="Variable aliases in form of NEW_NAME=BUILTIN_NAME")

    parser.parse_args(argv, namespace=FLAGS)

    def load_mapping_file(path):
        with open(path, "r") as f:
            return [line.strip().split("=", 1) for line in f if line.strip()]

    def make_variable_dict(mappings, aliases):
        builtin_vars = dict()
        for k, v in mappings:
            _check(k not in builtin_vars, "Duplicated builtin variable %s" % k)
            builtin_vars[k] = v
        alias_vars = dict()
        for new, old in aliases:
            if new in builtin_vars:
                sys.stderr.write("Aliasing builtin variable %s to %s" % (new, old))
            _check(new not in alias_vars, "Duplicated alias for %s" % new)
            alias_vars[new] = builtin_vars[old]
        builtin_vars.update(alias_vars)
        return builtin_vars

    variables = make_variable_dict(itertools.chain(*(load_mapping_file(f) for f in FLAGS.mappings)),
                                   (alias.split("=", 1) for alias in FLAGS.aliases))

    sys.stdout.write(string.Template(sys.stdin.read()).substitute(variables))

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
