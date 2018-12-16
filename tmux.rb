dep 'tmux.debian.apt', :version do
  requires 'debian-backports'
  met? { apt_installed? 'tmux', version }
  meet { apt_install 'tmux', version, 'stretch-backports' }
end

dep 'tmux.osx', :version do
  met? { shell? "tmux -V | grep #{version}" }
  meet { shell 'brew install tmux' }
end

dep 'tmux.conf.dotfile' do
  def name
    '.tmux.conf'
  end
  requires 'repo.dotfile', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep 'tmux-status.conf.dotfile' do
  def name
    '.tmux-status.conf'
  end
  requires 'repo.dotfile', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep 'tmux.dotfile' do
  requires 'tmux.conf.dotfile', 'tmux-status.conf.dotfile'
end

dep 'tmux' do
  on :debian do
    requires 'tmux.debian.apt'.with('2.8-2~bpo9+1')
  end

  on :osx do
    requires 'tmux.osx'.with('2.8')
  end

  requires 'tmux.dotfile'
end
