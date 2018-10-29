dep 'curl', :version do
  requires 'git.apt', 'libtoolize.apt', 'autoconf.apt', 'openssl'
  version.default!('7.61.1')
  met? { shell? "curl --version | grep #{version}" }
  meet {
    cd '/tmp' do
      shell 'rm -rf curl'
      shell 'git clone https://github.com/curl/curl.git'
      cd 'curl' do
        shell "git checkout curl-#{version.to_s.gsub('.', '_')}"
        shell './buildconf'
        shell 'LDFLAGS="-Wl,-rpath,/usr/local/ssl/lib -Wl,-rpath,/usr/local/lib" ./configure --with-ssl=/usr/local/ssl'
        shell 'make'
        shell 'make install', sudo: true
      end
    end
  }
  after do
    shell 'rm -rf /tmp/curl'
    shell 'apt-get remove -y curl', sudo: true
  end
end
