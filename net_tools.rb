dep 'net-tools.lib', :version do
  installs {
    via :apt, 'net-tools'
  }
end
