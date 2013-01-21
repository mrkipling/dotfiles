# requires GitPython
# pip install gitpython

from git import *

def trunc(str, amt=20):
    return str[:amt].strip() + '...' if len(str) > amt + 2 else str

repo = Repo("/path/to/repo")
assert repo.bare == False

print "\nGIT ${color #333333}${hr 2}${color #ffffff}\n"
print "Branch:${alignr}%s" % repo.head.reference
print "Working tree:${alignr}%s" % ("dirty" if repo.is_dirty() else "clean")
print "Log:${alignr}%s" % trunc(repo.head.reference.commit.message)
