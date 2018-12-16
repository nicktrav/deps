dep 'protoc', :version do
  version.default!('3.6.1')
  requires 'curl', 'dotfiles'
  met? { shell? "protoc --version | grep #{version}" }
  meet {
    install_dir='/usr/local/src/protoc'
    cd '/tmp' do
      artifact = nil
      on :osx do
        artifact = "protoc-#{version}-osx-x86_64"
      end
      on :debian do
        artifact = "protoc-#{version}-linux-x86_64"
      end
      url = "https://github.com/protocolbuffers/protobuf/releases/download/v#{version}/#{artifact}.zip"
      shell "curl -L -o protoc.zip #{url}"
      shell 'unzip protoc.zip -d protoc'
      shell "cp -r protoc #{install_dir}", sudo: true
      shell "ln -sf #{install_dir}/bin/protoc /usr/local/bin/protoc", sudo: true
    end
  }
  after do
    cd '/tmp' do
      shell 'rm -rf protoc*'
    end
  end
end
