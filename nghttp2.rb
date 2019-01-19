meta :nghttp2 do
  def dir
    '~/Development/nghttp2'
  end
end

dep 'source.nghttp2', :version do
  version.default!('1.35.0')
  met? { dir.p.exists? }
  meet {
    # uses system curl, which we remove later
    shell 'apt-get install -y curl', sudo: true
    cd dir, create: true do
      shell "curl -L -o nghttp2.tar.gz https://github.com/nghttp2/nghttp2/archive/v#{version}.tar.gz"
      shell 'tar xzf nghttp2.tar.gz -C ./ --strip 1'
      shell 'rm nghttp2.tar.gz'
    end
  }
  after {
    shell 'apt-get remove -y curl', sudo: true
  }
end

dep 'lib.nghttp2' do
  requires 'source.nghttp2', 'automake.bin', 'autoconf.bin', 'pkg-config.bin', 'make.bin'
  on :debian do
    requires 'libtoolize.bin'
  end

  on :osx do
    met? { '/usr/local/lib/libnghttp2.dylib'.p.exists? }
  end
  on :debian do
    met? { '/usr/local/lib/libnghttp2.so'.p.exists? }
  end

  meet {
    cd dir do
      shell 'autoreconf -i'
      shell 'automake'
      shell 'autoconf'
      shell './configure'
      shell 'make'

      # TODO(nickt): change all Debian installs to not install as root
      on :osx do
        shell 'make install'
      end
      on :debian do
        shell 'make install', sudo: true
      end
    end
  }
end
