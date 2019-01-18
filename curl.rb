dep 'curl', :version do
  version.default!('7.61.1')

  requires 'lib.boringssl', 'lib.nghttp2'
  requires 'autoconf.bin', 'make.bin'
  on :debian do
    requires 'libtoolize.bin'
  end

  met? { shell? "curl --version | grep -E '^curl #{version}'" }
  meet {
    cd '/tmp' do
      # uses system curl, which we remove later
      shell 'apt-get install -y curl', sudo: true
      shell "curl -L -o curl.tar.gz https://github.com/curl/curl/releases/download/curl-#{version.to_s.gsub('.', '_')}/curl-#{version}.tar.gz"
      shell 'tar xzf curl.tar.gz'

      cd "curl-#{version}" do
        shell './buildconf'

        on :debian do
          shell <<-HERE
          LIBS=-lpthread LDFLAGS="-static" ./configure \
            --disable-shared \
            --enable-static \
            --with-nghttp2=/usr/local \
            --with-ssl=$HOME/Development/boringssl
          HERE
          shell 'make'

          # TODO(nickt): change all Debian installs to not install as root
          shell 'make install', sudo: true
        end

        # Static compilation has issues on macOS, so we remove those flags.
        on :osx do
          shell <<-HERE
          ./configure \
            --with-nghttp2=/usr/local \
            --with-ssl=$HOME/Development/boringssl
          HERE
        shell 'make'
        shell 'make install'
        end
      end
    end
  }
  after do
    shell 'rm -rf /tmp/curl*'
    on :debian do
      shell 'apt-get remove -y curl', sudo: true
    end
  end
end
