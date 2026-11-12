project(
  'hello-world',
  ['c', 'cpp'],
  meson_version : '>= 1.3.0',
  version : '0.1',
  default_options : ['warning_level=3'],
)

dependencies = [
]

sources = [
  'src/main.cpp',
]

exe = executable(
  'hello-world',
  sources,
  dependencies : dependencies,
  install : true,
)

test('basic', exe)
