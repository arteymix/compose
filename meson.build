project('Compose', 'c', 'vala',
        version: '1.0.0-dev')

if not meson.is_subproject()
    add_global_arguments(['-Wno-unused'], language: 'c')
endif

meson.add_install_script('install.sh')

glib = dependency('glib-2.0')
xml = dependency('libxml-2.0')

subdir('src')
subdir('tests')
