dep 'openssl', :version do
  requires 'make.bin'
  version.default!('1.1.1c')
  met? { shell? "openssl version | grep -E '^OpenSSL #{version}'" }
  meet {
    cd '/tmp' do
      shell 'rm -rf openssl'
      shell 'git clone https://github.com/openssl/openssl.git'
      cd 'openssl' do
        shell "git checkout OpenSSL_#{version.to_s.gsub('.', '_')}"
        shell "./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl '-Wl,-rpath,\$(LIBRPATH)'"
        shell 'make'
        shell 'make install', sudo: true
        shell 'cp apps/openssl /usr/local/bin/', sudo: true
      end
    end
  }
  after do
    shell 'rm -rf /tmp/openssl'
    # TODO(nickt): Remove system openssl here too?
  end
end
