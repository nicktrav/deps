meta :boringssl do
  def dir
    '~/Development/boringssl'
  end
end

dep 'source.boringssl', :version do
  version.default!('8e8f250422663106d478f6927beefba289a95b37') # taken from latest chromium-stable
  met? { dir.p.exists? }
  meet {
    shell "mkdir -p #{dir}"
    cd dir do
      shell 'git clone https://boringssl.googlesource.com/boringssl .'
      shell "git checkout #{version}"
    end
  }
end

dep 'lib.boringssl', :version do
  requires 'source.boringssl', 'make.bin', 'cmake.bin', 'g++.bin', 'go.lang'
  met? { "#{dir}/lib/libssl.a".p.exists? && "#{dir}/lib/libcrypto.a".p.exists? }
  meet {
    cd dir do
      shell 'rm -rf build/ lib/ && mkdir build/ && mkdir lib/'
      cd 'build' do
        shell 'DCMAKE_BUILD_TYPE=Release cmake ..'
        shell 'make'
      end
      cd 'lib' do
        shell 'ln -s ../build/ssl/libssl.a'
        shell 'ln -s ../build/crypto/libcrypto.a'
      end
    end
  }
end
