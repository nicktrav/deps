dep 'gettext.lib' do
  installs {
    via :apt, 'gettext'
  }
end
