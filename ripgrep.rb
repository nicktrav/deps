dep 'ripgrep', :version do
  requires 'curl'
  version.default!('0.10.0')
  met? { shell? "rg --version | grep #{version}" }
  meet {
    cd '/tmp' do
      shell "curl -L -o rg.deb https://github.com/BurntSushi/ripgrep/releases/download/#{version}/ripgrep_#{version}_amd64.deb"
      shell 'apt install /tmp/rg.deb', sudo: true
      shell 'rm rg.deb'
    end
  }
end
