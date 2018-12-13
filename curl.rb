dep 'curl', :version do
  requires 'git.apt', 'libtoolize.apt', 'autoconf.apt', 'software-properties-common.apt', 'lib.boringssl'
  version.default!('7.61.1')
  met? { shell? "curl --version | grep #{version}" }
  meet {
    cd '/tmp' do
      shell 'rm -rf curl'
      shell 'git clone https://github.com/curl/curl.git'
      cd 'curl' do
        shell "git checkout curl-#{version.to_s.gsub('.', '_')}"
        shell './buildconf'
        shell 'LIBS=-lpthread LDFLAGS="-static" ./configure --disable-shared --enable-static --with-ssl=$HOME/Development/boringssl'
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
