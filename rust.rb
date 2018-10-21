require_relative './helpers.rb'

dep 'rustup' do
  requires 'curl'
  met? { shell? "#{rustup} --version" }
  meet {
    shell <<-HERE
      curl -Ssf https://sh.rustup.rs | sh -s -- -y
    HERE
  }
end

dep 'cargo', :version do
  requires 'rustup'
  met? { shell? "rustup component list | grep cargo" }
  meet { shell "rustup component add cago" }
end

dep 'rustc', :version do
  requires 'rustup'
  version.default!('1.29.0')
  met? { shell? "#{rustc} --version | grep #{version}" }
  meet { shell "#{rustup} update #{version} && #{rustup} default #{version}" }
end

dep 'rustfmt' do
  requires 'rustup'
  met? { shell? "#{rustup} component list | grep rustfmt-preview" }
  meet { shell "#{rustup} component add rustfmt-preview" }
end

dep 'rust-src' do
  requires 'rustup'
  met? { shell? "#{rustup} component list | grep rust-src" }
  meet { shell "#{rustup} component add rust-src" }
end

dep 'rusty-tags', :version do
  requires 'rustup'
  version.default!('3.0.0')
  met? { shell? "#{cargo} install --list | grep 'rusty-tags v#{version}'" }
  meet { shell "#{cargo} install --version #{version} rusty-tags" }
end

dep 'rust.all' do
  requires 'rustup', 'rustc', 'rustfmt', 'rust-src', 'rusty-tags'
end
