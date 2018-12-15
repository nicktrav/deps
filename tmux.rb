dep 'tmux.bin.local', :version  do
  requires 'personal:git'
  version.default!('2.8')
  met? { shell? "tmux -V | grep #{version}" }
  before {
    shell <<-HERE
      sudo apt-get -y install \
        autogen \
        automake \
        libevent-dev \
        libncurses5-dev \
        pkg-config && \
      rm -rf /tmp/tmux
    HERE
  }
  meet {
    shell <<-HERE
      cd /tmp && \
      git clone https://github.com/tmux/tmux.git && \
      cd tmux && \
      git fetch -t && git checkout #{version} && \
      sh autogen.sh && \
      autoreconf -i --force && ./configure && make && \
      sudo make install
    HERE
  }
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
  requires 'tmux.bin.local', 'tmux.dotfile'
end
