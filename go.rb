dep 'go.dir' do
  requires 'development dir'
  def dir
    '~/Development/go'.p
  end
  met? { dir.exists? }
  meet { shell "mkdir #{dir}" }
end

dep 'protoc-gen-go' do
  requires 'go.lang', 'go.dir', 'dotfiles'
  met? { login_shell 'go list github.com/golang/protobuf/protoc-gen-go' }
  meet { login_shell 'go get -u github.com/golang/protobuf/protoc-gen-go' }
end

dep 'go.lang', :version do
  version.default!('1.12.1')
  requires 'tar.bin'
  met? { shell? "go version | grep #{version}" }
  meet {
    # There is a circular dependency between go, curl and boringssl. To break
    # the cycle, use system curl, which we remove in the after step (below).
    on :osx do
      shell 'brew install curl'
    end
    on :debian do
      shell 'apt-get -y install curl', sudo: true
    end

    platform=
    on :osx do
      platform="darwin-amd64"
    end
    on :debian do
      platform="linux-amd64"
    end

    tarball="go#{version}.#{platform}.tar.gz"
    url="https://dl.google.com/go/#{tarball}"
    shell 'rm -rf /usr/local/go', sudo: true
    shell <<-HERE
      cd /tmp && curl -L -O #{url} && \
      sudo tar xzf #{tarball} -C /usr/local && \
      sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go && \
      rm #{tarball}
    HERE
  }
  after {
    on :osx do
      shell 'brew uninstall curl'
    end
    on :debian do
      shell 'apt-get remove -y curl', sudo: true
    end
  }
end

dep 'go' do
  requires 'go.dir', 'go.lang', 'protoc-gen-go'
end
