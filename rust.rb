meta :rust do
  def rustup
    '~/.cargo/bin/rustup'
  end

  def rustc
    '~/.cargo/bin/rustc'
  end

  def cargo
    '~/.cargo/bin/cargo'
  end
end

dep 'rustup.rust', :version do
  requires 'curl', 'dotfiles'
  version.default!('1.18.3')
  met? { shell? "#{rustup} --version | grep #{version}" }
  meet {
    url_base = "https://static.rust-lang.org/rustup/archive/#{version}"
    arch = nil
    on :debian do
      arch = 'x86_64-unknown-linux-gnu'
    end
    on :osx do
      arch = 'x86_64-apple-darwin'
    end
    url = "#{url_base}/#{arch}/rustup-init"
    cd '/tmp' do
      shell "curl -O -L #{url}"
      shell 'chmod +x rustup-init'
      shell './rustup-init -y'
    end
    after do
      shell 'rm /tmp/rustup-init'
    end
  }
end

dep 'cargo.rust', :version do
  requires 'rustup.rust', 'dotfiles'
  met? { shell? "rustup component list | grep cargo" }
  meet { shell "rustup component add cago" }
end

dep 'rustc.rust', :version do
  requires 'rustup.rust', 'dotfiles'
  version.default!('1.35.0')
  met? { shell? "#{rustc} --version | grep #{version}" }
  meet { shell "#{rustup} update #{version} && #{rustup} default #{version}" }
end

dep 'rustfmt.rust' do
  requires 'rustup.rust'
  met? { shell? "#{rustup} component list | grep rustfmt" }
  meet { shell "#{rustup} component add rustfmt" }
end

dep 'rust-src.rust' do
  requires 'rustup.rust', 'dotfiles'
  met? { shell? "#{rustup} component list | grep rust-src" }
  meet { shell "#{rustup} component add rust-src" }
end

dep 'rust' do
  requires [
    'rustup.rust',
    'rustc.rust',
    'rustfmt.rust',
    'rust-src.rust',
  ]
end
