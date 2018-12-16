dep 'automake.bin', :version do
  version.default!('1.15')
  provides "automake >= #{version}"
  installs {
    via :apt, 'automake'
    via :brew, 'automake'
  }
end
