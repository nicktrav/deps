dep 'tar.bin', :version do
  version.default!('1.29')
  provides "tar >= #{version}"
  installs {
    via :apt, 'tar'
    via :brew, 'tar'
  }
end
