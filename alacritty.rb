dep 'alacritty.osx' do
  met? { shell? 'brew cask list alacritty' }
  meet {
    shell 'brew cask install alacritty'
  }
end

dep 'alacritty.debian.apt', :version do
  version.default!('0.2.9')
  requires 'libexpat', 'libfontconfig', 'libfreetype', 'libgcc', 'libpng', 'zlib'
  met? { apt_installed? 'alacritty', version }
  meet {
    cd '/tmp' do
      shell "curl -o alacritty.deb -L https://github.com/jwilm/alacritty/releases/download/v#{version}/Alacritty-v#{version}_amd64.deb"
      shell 'dpkg -i alacritty.deb', sudo: true
    end
  }
  after {
    shell 'rm -rf /tmp/alacritty.deb'
  }
end

dep 'alacritty' do
  requires 'dotfiles'
  on :osx do
    requires 'alacritty.osx'
  end
  on :debian do
    requires 'alacritty.debian.apt'
  end
end
