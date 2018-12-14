dep 'curl', :version do
  requires 'libtoolize.apt', 'autoconf.apt', 'software-properties-common.apt'
  requires 'git.apt', 'lib.boringssl', 'lib.nghttp2'
  version.default!('7.61.1')
  met? { shell? "curl --version | grep #{version}" }
  meet {
    cd '/tmp' do
      shell 'rm -rf curl'
      shell 'git clone https://github.com/curl/curl.git'
      cd 'curl' do
        shell "git checkout curl-#{version.to_s.gsub('.', '_')}"
        shell './buildconf'
        shell <<-HERE
          LIBS=-lpthread LDFLAGS="-static" ./configure \
            --disable-shared \
            --enable-static \
            --with-nghttp2=/usr/local \
            --with-ssl=$HOME/Development/boringssl
        HERE
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
