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

dep 'rustup.rust' do
  requires 'curl', 'dotfiles'
  met? { shell? "#{rustup} --version" }
  meet {
    shell <<-HERE
      curl -Ssf https://sh.rustup.rs | sh -s -- -y
    HERE
  }
end

dep 'cargo.rust', :version do
  requires 'rustup.rust', 'dotfiles'
  met? { shell? "rustup component list | grep cargo" }
  meet { shell "rustup component add cago" }
end

dep 'rustc.rust', :version do
  requires 'rustup.rust', 'dotfiles'
  version.default!('1.32.0')
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
