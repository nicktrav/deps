dep 'libz.lib' do
  installs {
    via :apt, 'zlib1g-dev'
  }
end
