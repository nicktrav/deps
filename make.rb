dep 'make.bin', :version do
  version.default!('4.1')
  provides "make >= #{version}"
  installs {
    via :apt, 'make'
    via :brew, 'make'
  }
end
