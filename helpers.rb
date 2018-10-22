def apt_installed?(package, version)
  shell? "apt-cache policy #{package} | grep 'Installed: #{version}'"
end

def apt_install(package, version)
  shell "apt-get -y install #{package}=#{version}", sudo: true
end

def dotfiles_dir
  "~/Development/dotfiles".p
end

def dotfiles_file(file)
  "#{dotfiles_dir}/#{file}".p
end

def dotfile_exists?(filename)
  "~/#{filename}".p.exists?
end

def link_dotfile(filename)
  shell "ln -s #{dotfiles_dir}/#{filename} ~/#{filename}"
end

def rustup
  '~/.cargo/bin/rustup'
end

def rustc
  '~/.cargo/bin/rustc'
end

def cargo
  '~/.cargo/bin/cargo'
end
