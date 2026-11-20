# Xmake Project
My C/C++ project using [Xmake](https://xmake.io/) build system.

## Project Structure
```txt
./
├─ build/
│  └─ <out>/
│     ├─ bin/
│     ├─ sbin/ - sys-admin programs (root user only)
│     ├─ lib/
│     ├─ libexec/ - helper scripts
│     ├─ include/
│     ├─ share/
│     └─ etc/
│
├─ docs/
│  └─ justfile - build documentation
│
├─ tools/ - developer scripts & integrations
│
├─ tests/ - for tests that don't belong in src/<target>/tests/
│  ├─ xmake.lua
│  └─ justfile - `just test` interface
│
├─ dist/ - platform-dependent distribution files
│  ├─ icons/
│  ├─ fonts/
│  ├─ freedesktop/<pname>.desktop
│  ├─ darwin/
│  ├─ windows/
│  └─ release_notes.txt
│
├─ assets/ - runtime assets copied to build/<out>/share/<pname>/
│  ├─ textures/
│  ├─ audio/
│  ├─ models/
│  ├─ data/
│  └─ etc/
│
├─ repo/packages/ - local package definitions for Xrepo
│
├─ extern/ - git submodules
│  └─ xmake.lua - expose git submodules as Xmake project targets
│
├─ src/
│  ├─ <target_name>/ - builds an Xmake project target
│  │  └─ xmake.lua - describes outputs for the directories in build/<dist>/
│  │
│  └─ <pname>/ - default target
│     ├─ tests/ - unit tests
│     ├─ include/
│     ├─ lua/
│     ├─ main.c
│     └─ xmake.lua
│
├─ xmake.lua
└─ justfile
```
