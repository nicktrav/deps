dep 'protoc', :version do
  requires 'curl', 'dotfiles'
  version.default!('3.6.1')
  met? { shell? "protoc --version | grep #{version}" }
  meet {
    install_dir='/usr/local/src/protoc'
    cd '/tmp' do
      shell 'curl -L -o protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-x86_64.zip'
      shell 'unzip protoc.zip -d protoc'
      shell "cp -r protoc #{install_dir}", sudo: true
      shell "ln -s #{install_dir}/bin/protoc /usr/local/bin/protoc", sudo: true
    end
  }
  after do
    cd '/tmp' do
      shell 'rm -rf protoc*'
    end
  end
end
