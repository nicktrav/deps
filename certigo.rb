dep 'source.certigo'  do
  requires 'go.lang'
  met? { login_shell 'go list github.com/square/certigo' }
  meet { login_shell 'go get github.com/square/certigo' }
end

dep 'binary.certigo', :version do
  version.default!('1.11.0')
  requires 'source.certigo', 'dotfiles'
  met? { login_shell "certigo --version 2>&1 | grep #{version}" }
  meet {
    cd '~/Development/go/src/github.com/square/certigo' do
      shell "git checkout v#{version}"
      shell 'go install'
    end
  }
end

dep 'certigo' do
  requires 'binary.certigo'
end
