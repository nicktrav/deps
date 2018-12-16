dep 'libevent.lib' do
  installs {
    via :apt, 'libevent-dev'
  }
end
