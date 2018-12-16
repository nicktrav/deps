dep 'pkg-config.bin', :version do
  version.default!('0.29')
  provides "pkg-config >= #{version}"
  installs {
    via :apt, 'pkg-config'
  }
end
