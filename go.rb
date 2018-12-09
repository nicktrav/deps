dep 'go.lang', :version  do
  requires 'curl', 'tar.apt', 'dotfiles'
  version.default!('1.11.2')
  met? { shell? "go version | grep #{version}" }
  meet {
    tarball="go#{version}.linux-amd64.tar.gz"
    url="https://dl.google.com/go/#{tarball}"
    shell <<-HERE
      cd /tmp && curl -L -O #{url} && \
      sudo tar xzf #{tarball} -C /usr/local && \
      sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go && \
      rm #{tarball}
    HERE
  }
end

dep 'go.dir' do
  def dir
    '~/Development/go'.p
  end
  met? { dir.exists? }
  meet { shell "mkdir #{dir}" }
end

dep 'protoc-gen-go' do
  requires 'go.lang', 'go.dir'
  met? { login_shell 'go list github.com/golang/protobuf/protoc-gen-go' }
  meet { login_shell 'go get -u github.com/golang/protobuf/protoc-gen-go' }
end

dep 'go' do
  requires 'go.lang', 'protoc-gen-go'
end
