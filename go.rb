dep 'go.dir' do
  requires 'development dir'
  def dir
    '~/Development/go'.p
  end
  met? { dir.exists? }
  meet { shell "mkdir #{dir}" }
end

dep 'go.debian', :version do
  requires 'tar.bin'
  met? { shell? "go version | grep #{version}" }
  meet {
    # There is a circular dependency between go, curl and boringssl. To break
    # the cycle, use system curl, which we remove in the after step (below).
    shell 'apt-get -y install curl', sudo: true

    tarball="go#{version}.linux-amd64.tar.gz"
    url="https://dl.google.com/go/#{tarball}"
    shell <<-HERE
      cd /tmp && curl -L -O #{url} && \
      sudo tar xzf #{tarball} -C /usr/local && \
      sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go && \
      rm #{tarball}
    HERE
  }
  after {
    shell 'apt-get remove -y curl', sudo: true
  }
end

dep 'go.osx.bin', :version do
  met? { shell? "go version | grep #{version}" }
  installs {
    via :brew, 'go'
  }
end

dep 'protoc-gen-go' do
  requires 'go.lang', 'go.dir', 'dotfiles'
  met? { login_shell 'go list github.com/golang/protobuf/protoc-gen-go' }
  meet { login_shell 'go get -u github.com/golang/protobuf/protoc-gen-go' }
end

dep 'go.lang', :version do
  version.default!('1.12.1')
  on :osx do
    requires 'go.osx.bin'.with(version)
  end
  on :debian do
    requires 'go.debian'.with(version)
  end
end

dep 'go' do
  requires 'go.dir', 'go.lang', 'protoc-gen-go'
end
