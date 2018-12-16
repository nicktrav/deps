meta :nghttp2 do
  def dir
    '~/Development/nghttp2'
  end
end

dep 'source.nghttp2' do
  requires 'personal:git'
  met? { dir.p.exists? }
  meet {
    shell "mkdir -p #{dir}"
    cd dir do
      shell 'git clone https://github.com/tatsuhiro-t/nghttp2.git .'
    end
  }
end

dep 'lib.nghttp2', :version do
  version.default!('v1.35.0')
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
      shell "git checkout #{version}"
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
