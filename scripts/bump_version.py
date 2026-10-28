"""Bump the patch number of the version line in fxmanifest.lua.

With --current, print the version as it stands and change nothing.
Either way the version is also written to GITHUB_OUTPUT as `version`.
"""
import os
import re
import sys

MANIFEST = 'fxmanifest.lua'
# The first `version 'x.y.z'` line, either quote style; a suffix such as the
# `a` in '0.0.2a' is kept by --current and dropped by a bump.
PATTERN = re.compile(r"""^([ \t]*version[ \t]*)(['"])(\d+)\.(\d+)\.(\d+)([^'"\n]*)\2""", re.MULTILINE)


def output(version):
    if 'GITHUB_OUTPUT' in os.environ:
        with open(os.environ['GITHUB_OUTPUT'], 'a') as f:
            f.write(f'version={version}\n')


with open(MANIFEST, 'r', encoding='utf-8', newline='') as f:
    contents = f.read()

match = PATTERN.search(contents)
if not match:
    print(f"No version 'x.y.z' line found in {MANIFEST}")
    sys.exit(1)

prefix, quote, major, minor, patch, suffix = match.groups()

if '--current' in sys.argv[1:]:
    current = f'{major}.{minor}.{patch}{suffix}'
    print(current)
    output(current)
    sys.exit(0)

new_version = f'{major}.{minor}.{int(patch) + 1}'
contents = contents[:match.start()] + f'{prefix}{quote}{new_version}{quote}' + contents[match.end():]

with open(MANIFEST, 'w', encoding='utf-8', newline='') as f:
    f.write(contents)

print(f'Bumped version to {new_version}')
output(new_version)
