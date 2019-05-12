dep 'ripgrep.debian', :version do
  requires 'curl'
  met? { shell? "rg --version | grep #{version}" }
  meet {
    cd '/tmp' do
      shell "curl -L -o rg.deb https://github.com/BurntSushi/ripgrep/releases/download/#{version}/ripgrep_#{version}_amd64.deb"
      shell 'apt install /tmp/rg.deb', sudo: true
      shell 'rm rg.deb'
    end
  }
end

dep 'ripgrep.osx', :version do
  met? { in_path? "rg >= #{version}" }
  meet {
    shell 'brew install rg'
  }
end

dep 'ripgrep', :version do
  version.default!('11.0.1')
  on :osx do
    requires 'ripgrep.osx'.with(version)
  end
  on :debian do
    requires 'ripgrep.debian'.with(version)
  end
end
