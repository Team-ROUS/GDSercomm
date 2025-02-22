#!python
import os, subprocess

# Local dependency paths, adapt them to your setup
godot_headers_path = ARGUMENTS.get("headers", os.getenv("GODOT_HEADERS", "./godot_headers/"))
sercomm_header_path = ARGUMENTS.get("sercomm", os.getenv("SERCOMM_HEADERS", "./sercomm/include/public/"))
libraries= ARGUMENTS.get("sercomm", os.getenv("LIBS", "./lib/"))

target = ARGUMENTS.get("target", "debug")

# platform= makes it in line with Godots scons file, keeping p for backwards compatibility
platform = ARGUMENTS.get("p", "linux")
platform = ARGUMENTS.get("platform", platform)

# This makes sure to keep the session environment variables on windows, 
# that way you can run scons in a vs 2017 prompt and it will find all the required tools
env = Environment()
if platform == "windows":
    env = Environment(ENV = os.environ)

if ARGUMENTS.get("use_llvm", "no") == "yes":
    env["CC"] = "clang"

def add_sources(sources, directory):
    for file in os.listdir(directory):
        if file.endswith('.c'):
            sources.append(directory + '/' + file)

if platform == "osx":
    env.Append(CCFLAGS = ['-g','-O3', '-arch', 'arm64'])
    env.Append(LINKFLAGS = ['-arch', 'arm64'])

if platform == "linux":
    env.Append(CCFLAGS = ['-fPIC', '-g','-O3', '-std=c99','-Wall'])

if platform == "windows":
    if target == "debug":
        env.Append(CCFLAGS = ['-EHsc', '-D_DEBUG', '/MDd'])
    else:
        env.Append(CCFLAGS = ['-O2', '-EHsc', '-DNDEBUG', '/MD'])


# , 'include', 'include/core'
env.Append(CPPPATH=['.', godot_headers_path , sercomm_header_path, libraries])

sources = []
add_sources(sources, "src")

env.AppendUnique(FRAMEWORKS=Split('Foundation IOKit'))

env.Append(LIBS = ['sercomm'])
env.Append(LIBPATH = [libraries])

library = env.SharedLibrary(target='bin/GDSercomm', source=sources)

Default(library)