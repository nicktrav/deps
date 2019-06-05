dep 'openjdk.latest.bash', :version do
  version.default! 'openjdk@1.13.0-23'
  requires 'jabba', 'dotfiles'
  met? { login_shell "jabba ls | grep #{version}" }
  meet {
    login_shell "jabba install #{version}"
    login_shell "jabba alias default #{version}"
  }
end

dep 'openjdk.11.bash', :version do
  version.default! 'openjdk@1.11.0-2'
  requires 'jabba', 'dotfiles'
  met? { login_shell "jabba ls | grep #{version}" }
  meet {
    login_shell "jabba install #{version}"
  }
end

dep 'openjdk.8.bash', :version do
  version.default! 'adopt@1.8.212-03'
  requires 'jabba', 'dotfiles'
  met? { login_shell "jabba ls | grep #{version}" }
  meet {
    login_shell "jabba install #{version}"
  }
end

dep 'java' do
  requires 'openjdk.latest.bash'
  requires 'openjdk.11.bash'
  requires 'openjdk.8.bash'
end
