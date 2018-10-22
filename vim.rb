dep 'vim.apt', :version do
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

dep 'vim.colors' do
  def colors_dir
    '~/.vim/colors'.p
  end

  def filename
    'Tomorrow-Night.vim'
  end

  def colors_file
    "#{colors_dir}/#{filename}".p
  end

  requires 'dotfiles-repo'
  met? { colors_file.exists? }
  meet {
    cd colors_dir, create: true do
      shell "ln -s #{dotfiles_file('colors/' + filename)} #{colors_file}"
    end
  }
end

dep 'vim' do
  requires 'vim.apt', 'vim.dotfiles', 'vim.colors'
end
