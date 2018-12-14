meta :nghttp2 do
  def dir
    '~/Development/nghttp2'
  end
end

dep 'source.nghttp2' do
  requires 'git.apt'
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
  requires 'source.nghttp2', 'automake.apt', 'autoconf.apt', 'pkg-config.apt'
  met? { '/usr/local/lib/libnghttp2.so'.p.exists? }
  meet {
    cd dir do
      shell "git checkout #{version}"
      shell 'autoreconf -i'
      shell 'automake'
      shell 'autoconf'
      shell './configure'
      shell 'make'
      shell 'make install', sudo: true
    end
  }
end
