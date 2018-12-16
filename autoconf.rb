dep 'autoconf.bin', :version do
  version.default!('2.69')
  provides "autoconf >= #{version}"
  installs {
    via :apt, 'autoconf'
    via :brew, 'autoconf'
  }
end
