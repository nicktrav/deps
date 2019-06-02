dep 'rusty-tags.rust', :version do
  requires 'rustup.rust', 'dotfiles'
  version.default!('3.5.1')
  met? { shell? "#{cargo} install --list | grep 'rusty-tags v#{version}'" }
  meet { shell "#{cargo} install --force --version #{version} rusty-tags" }
end
