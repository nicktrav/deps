dep 'vim.debian.apt', :version do
  met? { apt_installed? 'vim', version }
  meet { apt_install 'vim', version }
end

dep 'vim.osx', :version do
  met? { in_path? "vim >= #{version}" }
  meet { shell 'brew install vim --with-override-system-vi' }
end

dep 'vim' do
  on :debian do
    requires 'vim.debian.apt'.with('2:8.0.0197-4+deb9u1')
  end
  on :osx do
    requires 'vim.osx'.with('8.1')
  end
  requires 'dotfiles'
end
