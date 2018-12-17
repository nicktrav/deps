dep 'alacritty.osx' do
  met? { shell? 'brew cask list alacritty' }
  meet {
    shell 'brew cask install alacritty'
  }
end

dep 'alacritty' do
  requires 'dotfiles'
  on :osx do
    requires 'alacritty.osx'
  end
  # TODO(nickt): add debian build
end
