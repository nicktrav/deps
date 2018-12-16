dep 'cmake.bin', :version do
  version.default!('3.7.2')
  provides "cmake >= #{version}"
  installs {
    via :apt, 'cmake'
    via :brew, 'cmake'
  }
end
