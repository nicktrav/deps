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

dep '.aliases.dotfile' do
  def name
    '.aliases'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.bash_profile.dotfile' do
  def name
    '.bash_profile'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.bash_prompt.dotfile' do
  def name
    '.bash_prompt'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.docker_functions.dotfile' do
  def name
    '.docker_functions'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.functions.dotfile' do
  def name
    '.functions'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.gitconfig.dotfile' do
  def name
    '.gitconfig'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.inputrc.dotfile' do
  def name
    '.inputrc'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.paths.dotfile' do
  def name
    '.paths'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.bash_local.dotfile' do
  def name
    'debian/.bash_local'
  end
  requires 'repo.dotfile'
  met? { dotfile_exists? '.bash_local' }
  meet { shell "ln -s #{dotfiles_dir}/#{name} ~/.bash_local" }
end

dep 'dotfiles' do
  requires [
    'repo.dotfile',
    '.aliases.dotfile',
    '.bash_profile.dotfile',
    '.bash_prompt.dotfile',
    '.docker_functions.dotfile',
    '.functions.dotfile',
    '.inputrc.dotfile',
    '.paths.dotfile',
    '.bash_local.dotfile',
  ]
end
