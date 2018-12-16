dep 'curses.lib' do
  installs {
    via :apt, 'libncurses5-dev'
  }
end

