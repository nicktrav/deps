dep 'openjdk.bash', :version do
  version.default! 'openjdk@1.10.0'
  requires 'jabba', 'dotfiles'
  met? { login_shell "jabba current | grep #{version}" }
  meet {
    login_shell "jabba install #{version}"
    login_shell "jabba alias default #{version}"
  }
end

dep 'java' do
  requires 'openjdk.bash'
end
