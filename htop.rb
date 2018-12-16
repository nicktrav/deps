dep 'htop.bin', :version do
  version.default!('2.0.2')
  provides "htop >= #{version}"
  installs {
    via :apt, 'htop'
    via :brew, 'htop'
  }
end
