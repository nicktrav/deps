meta :dotfile do
  def dotfiles_dir
    "~/Development/dotfiles".p
  end

  def dotfiles_file(filename)
    raise "dotfile must start with a ." unless filename.start_with? '.'
    "#{dotfiles_dir}/#{filename}".p
  end

  def dotfile_exists?(filename)
    raise "dotfile must start with a ." unless filename.start_with? '.'
    "~/#{filename}".p.exists?
  end

  def link_dotfile(filename)
    raise "dotfile must start with a ." unless filename.start_with? '.'
    shell "ln -s #{dotfiles_file(filename)} ~/#{filename}"
  end

  def version_file
    "~/.dotfiles_version"
  end
end

dep 'repo.dotfile', :version  do
  requires 'personal:git', 'development dir'
  version.default!('master')
  met? { dotfiles_dir.exists? }
  meet {
    shell <<-HERE
      git clone \
        --branch #{version} \
        --depth 1 \
        https://github.com/nicktrav/dotfiles.git \
        #{dotfiles_dir}
    HERE
  }
end

dep 'version.dotfile' do
  requires 'repo.dotfile'
  met? {
    login_shell "[[ $(cat #{version_file}) == $(cd #{dotfiles_dir} && git rev-parse HEAD) ]]"
  }
  meet {
    cd dotfiles_dir do
      on :osx do
        shell './install.sh macos'
      end
      on :debian do
        shell './install.sh debian'
      end
      shell "git rev-parse HEAD > #{version_file}"
    end
  }
end

dep 'dotfiles' do
  requires 'repo.dotfile', 'version.dotfile'
  requires 'tmux'
end
