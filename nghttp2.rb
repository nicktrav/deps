meta :nghttp2 do
  def dir
    '~/Development/nghttp2'
  end
end

dep 'source.nghttp2', :version do
  version.default!('1.37.0')
  met? { dir.p.exists? }
  meet {
    cd dir, create: true do
      shell 'git clone https://github.com/nghttp2/nghttp2.git .'
      shell "git checkout v#{version}"
    end
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
