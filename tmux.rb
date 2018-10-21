dep 'tmux', :version  do
  requires 'git.local'
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
