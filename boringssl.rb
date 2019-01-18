meta :boringssl do
  def dir
    '~/Development/boringssl'
  end
end

dep 'source.boringssl', :version do
  version.default!('2d98d49cf712ca7dc6f4b23b9c5f5542385d8dbe') # taken from latest chromium-stable
  met? { dir.p.exists? }
  meet {
    # uses system curl, which we remove later
    shell 'apt-get install -y curl', sudo: true
    shell "mkdir -p #{dir}"
    cd dir do
      shell "curl -L -o boringssl.tar.gz https://boringssl.googlesource.com/boringssl/+archive/#{version}.tar.gz"
      shell 'tar xzf boringssl.tar.gz -C ./'
      shell 'rm boringssl.tar.gz'
    end
  }
  after {
    shell 'apt-get remove -y curl', sudo: true
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
