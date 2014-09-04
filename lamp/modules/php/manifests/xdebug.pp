class php::xdebug {

  package { "php5-xdebug":
    ensure => present,
    require => Package["php5"],
  }
  
  # Update config.
  file {'/etc/php5/mods-available/xdebug.ini':
    path => '/etc/php5/mods-available/xdebug.ini',
    ensure => present,
    require => Package["php5", "php5-xdebug"],
    owner => root, group => root, mode => 444,
    content => "
        zend_extension=xdebug.so

        ; For debug in CLI run before script 'export XDEBUG_CONFIG='idekey=netbeans-xdebug''.
        ; PHP Storm IDE key is PHPSTORM
        ; For debug service (SOAP, REST) set cookie on client setCookie('XDEBUG_SESSION', 'netbeans-xdebug')
        ; then debug progect. Some times need restart apache and Netbeans.

        ; Remote settings
        xdebug.remote_autostart=off
        xdebug.remote_enable=on
        xdebug.remote_handler=dbgp
        xdebug.remote_mode=req
        xdebug.remote_host=10.0.2.2
        xdebug.remote_port=9000
        xdebug.remote_connect_back = on
        xdebug.idekey=PHPSTORM

        ; General
        xdebug.show_local_vars=On
        xdebug.dump.SERVER=HTTP_HOST, SERVER_NAME
        xdebug.dump_globals=On
        xdebug.collect_params=4
        xdebug.auto_trace=off
        xdebug.collect_includes=on
        xdebug.collect_return=off
        xdebug.default_enable=on
        xdebug.extended_info=1
        xdebug.manual_url=http://www.php.net
        xdebug.show_mem_delta=1
        xdebug.max_nesting_level=100

        ;var_dump
        ;Default value: 128
        xdebug.var_display_max_children=164
        ;Default value: 512
        xdebug.var_display_max_data=640
        ;Default value: 3
        xdebug.var_display_max_depth=6

        ; Trace options
        ;xdebug.trace_format=0
        ;xdebug.trace_output_dir=/var/www/debug
        ;xdebug.trace_options=0
        ;xdebug.trace_output_name=tracelog

        ; Profiling
        ;xdebug.profiler_append=0
        ;xdebug.profiler_enable=0
        ;xdebug.profiler_enable_trigger=0
        ;xdebug.profiler_output_dir=/var/www/debug
        ;xdebug.profiler_output_name=scriptprofile.out
    ",
  }

  # Symlink on overrided php config file.
  file { "/etc/php5/apache2/conf.d/20-xdebug.ini":
    ensure => link,
    target => "/etc/php5/mods-available/xdebug.ini",
    require => File["/etc/php5/mods-available/xdebug.ini"],
    notify => Service["apache2"],
  }
}
