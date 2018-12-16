dep 'host.bin', :version do
  version.default!('9.10.3')
  met? { shell "host -V 2>&1 | grep #{version}" }
  installs {
    via :apt, 'host'
  }
end
