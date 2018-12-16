dep 'libtoolize.bin', :version do
  version.default!('2.4.6')
  provides "libtoolize >= #{version}"
  installs {
    via :apt, 'libtool'
  }
end
