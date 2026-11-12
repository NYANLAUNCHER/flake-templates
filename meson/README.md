# Meson Build Template
My C/C++ build template using [Meson](https://mesonbuild.com/index.html).

## Example Project Structure
Note, 'local' and 'external' refer to a component or dependency being managed locally in this repo or externally from another git repo. \
The output directories in build/ must be coordinated across components.
```txt
./
├─ build/ - Meson build files
│  └─ <dist>/ - Distribution files
│     ├─ bin/
│     ├─ etc/
│     ├─ include/
│     ├─ lib/
│     ├─ libexec/ - helper scripts
│     ├─ sbin/ - sys-admin programs
│     └─ share/
│
├─ docs/
│  └─ mod.just - Build documentation
│
├─ tests/
│  └─ meson.build
│
├─ assets/ - Runtime Assets
│  ├─ <asset_type>/ - textures, audio, models, shaders, lua
│  ├─ data/ - static data, usually csv or binary
│  ├─ etc/
│  └─ desktop/ - for targets with a desktop environment
│     ├─ icons/
│     ├─ fonts/
│     ├─ themes/
│     └─ <pname>.desktop
│
├─ lib/ - External Dependencies
│  ├─ <ext_lib>/
│  └─ meson.build - build and expose external libraries for submodules in src/
│
├─ src/ - Local Submodules
│  ├─ <lib>/ - build dynamic and static libraries
│  │  ├─ <lib1>.c
│  │  ├─ <lib1>.h
│  │  └─ meson.build
│  └─ main/ - accessible from other components as <pname>
│     ├─ lua/
│     ├─ include/
│     ├─ main.c
│     └─ meson.build
│
├─ meson.build
└─ justfile
```
