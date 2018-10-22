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
  requires 'curl.apt'
  met? { shell? "#{rustup} --version" }
  meet {
    shell <<-HERE
      curl -Ssf https://sh.rustup.rs | sh -s -- -y
    HERE
  }
end

dep 'cargo.rust', :version do
  requires 'rustup.rust'
  met? { shell? "rustup component list | grep cargo" }
  meet { shell "rustup component add cago" }
end

dep 'rustc.rust', :version do
  requires 'rustup.rust'
  version.default!('1.29.0')
  met? { shell? "#{rustc} --version | grep #{version}" }
  meet { shell "#{rustup} update #{version} && #{rustup} default #{version}" }
end

dep 'rustfmt.rust' do
  requires 'rustup.rust'
  met? { shell? "#{rustup} component list | grep rustfmt-preview" }
  meet { shell "#{rustup} component add rustfmt-preview" }
end

dep 'rust-src.rust' do
  requires 'rustup.rust'
  met? { shell? "#{rustup} component list | grep rust-src" }
  meet { shell "#{rustup} component add rust-src" }
end

dep 'rusty-tags.rust', :version do
  requires 'rustup.rust'
  version.default!('3.0.0')
  met? { shell? "#{cargo} install --list | grep 'rusty-tags v#{version}'" }
  meet { shell "#{cargo} install --version #{version} rusty-tags" }
end

dep 'rust' do
  requires 'rustup.rust', 'rustc.rust', 'rustfmt.rust', 'rust-src.rust', 'rusty-tags.rust'
end
