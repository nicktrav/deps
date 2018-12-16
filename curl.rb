dep 'curl', :version do
  version.default!('7.61.1')

  requires 'personal:git', 'lib.boringssl', 'lib.nghttp2'
  requires 'autoconf.bin', 'make.bin'
  on :debian do
    requires 'libtoolize.bin'
  end

  met? { shell? "curl --version | grep #{version}" }
  meet {
    cd '/tmp' do
      shell 'rm -rf curl'
      shell 'git clone https://github.com/curl/curl.git'
      cd 'curl' do
        shell "git checkout curl-#{version.to_s.gsub('.', '_')}"
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
    shell 'rm -rf /tmp/curl'
    on :debian do
      shell 'apt-get remove -y curl', sudo: true
    end
  end
end
