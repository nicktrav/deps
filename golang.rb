dep 'golang', :version  do
  requires 'curl', 'tar.apt', 'dotfiles'
  version.default!('1.11')
  met? { shell? "go version | grep #{version}" }
  meet {
    tarball="go#{version}.linux-amd64.tar.gz"
    url="https://dl.google.com/go/#{tarball}"
    shell <<-HERE
      cd /tmp && curl -L -O #{url} && \
      sudo tar xzf #{tarball} -C /usr/local && \
      sudo ln -s /usr/local/go/bin/go /usr/local/bin/go && \
      rm #{tarball}
    HERE
  }
end
