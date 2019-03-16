dep 'tmux.debian.backports', :version do
  requires 'debian-backports'
  met? { in_path? "tmux >= #{version}" }
  meet { apt_install 'tmux' }
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
    requires 'tmux.debian.backports'.with('2.8')
  end

  on :osx do
    requires 'tmux.osx'.with('2.8')
  end

  requires 'tmux.dotfile'
end
