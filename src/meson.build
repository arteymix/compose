compose_lib = library('compose-1.0', ['compose.vala', 'compose-html5.vala'],
                      dependencies: [glib_dep, libxml_dep],
                      vala_header: 'compose.h',
                      install: true,
                      install_dir: [true, true, true])

compose_dep = declare_dependency(link_with: compose_lib,
                                 include_directories: include_directories('.'))

pkgconfig = import('pkgconfig')
pkgconfig.generate(requires: 'glib-2.0',
                   requires_private: 'libxml-2.0',
                   libraries: compose_lib,
                   name: 'Compose',
                   filebase: 'compose-1.0',
                   description: 'Functionnal templating for Vala',
                   version: meson.project_version(),
                   subdirs: 'compose-1.0')
