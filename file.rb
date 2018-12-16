dep 'file.bin', :version do
  version.default!('5.30')
  provides "file >= file-#{version}"
  installs {
    via :apt, 'file'
  }
end
