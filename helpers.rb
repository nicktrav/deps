def apt_installed?(package, version)
  shell? "apt-cache policy #{package} | grep 'Installed: #{version}'"
end

def apt_install(package, version)
  shell "apt-get -y install #{package}=#{version}", sudo: true
end

def dotfiles_dir
  "~/Development/dotfiles".p
end

def dotfiles_file(filename)
  raise "dotfile must start with a ." unless filename.start_with? '.'
  "#{dotfiles_dir}/#{filename}".p
end

def dotfile_exists?(filename)
  raise "dotfile must start with a ." unless filename.start_with? '.'
  "~/#{filename}".p.exists?
end

def link_dotfile(filename)
  raise "dotfile must start with a ." unless filename.start_with? '.'
  shell "ln -s #{dotfiles_file(filename)} ~/#{filename}"
end
