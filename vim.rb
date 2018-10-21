require_relative './helpers.rb'

dep 'vim.bin.local', :version do
  version.default!('2:8.0.0197-4+deb9u1')
  met? { apt_installed? 'vim', version }
  meet { apt_install 'vim', version }
end

dep 'vim.dotfiles' do
  def name
    '.vimrc'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep 'vim' do
  requires 'vim.bin.local', 'vim.dotfiles'
end
