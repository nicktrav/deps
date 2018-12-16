dep 'source.jabba.bash' do
  requires 'go', 'dotfiles'
  met? { login_shell 'go list github.com/shyiko/jabba' }
  meet { login_shell 'go get github.com/shyiko/jabba' }
end

dep 'binary.jabba.bash', :version do
  version.default! '0.11.0'
  requires 'source.jabba.bash', 'development dir', 'git', 'go', 'curl'
  met? { login_shell "jabba --version | grep #{version}" }
  meet {
    cd "~/Development/go/src/github.com/shyiko/jabba".p do
      shell 'git checkout master'
      shell 'git fetch -t'
      shell "git checkout #{version}"
      shell 'bash install.sh'
    end
  }
end

dep 'jabba' do
  requires 'source.jabba.bash'
  requires 'binary.jabba.bash'
end
