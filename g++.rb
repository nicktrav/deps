dep 'g++.bin', :version do
  version.default!('6.3.0')
  provides "g++ >= #{version}"
  installs {
    via :apt, 'g++'
  }
end
