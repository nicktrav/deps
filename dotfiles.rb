require_relative './helpers.rb'

dep 'dotfiles-repo', :version  do
  def dir
    '~/Development/dotfiles'.p
  end

  requires 'git.local', 'development dir'
  version.default!('master')
  met? { dir.exists? }
  meet {
    shell <<-HERE
      git clone \
        --branch #{version} \
        --single-branch https://github.com/nicktrav/dotfiles.git \
        #{dir}
    HERE
  }
end

dep '.aliases link' do
  def name
    '.aliases'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.bash_profile link' do
  def name
    '.bash_profile'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.bash_prompt link' do
  def name
    '.bash_prompt'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.docker_functions link' do
  def name
    '.docker_functions'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.functions link' do
  def name
    '.functions'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.gitconfig link' do
  def name
    '.gitconfig'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.inputrc link' do
  def name
    '.inputrc'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep '.paths link' do
  def name
    '.paths'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

# TODO(nickt): Move to tmux dep
dep '.tmux-status.conf link' do
  def name
    '.tmux-status.conf'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

# TODO(nickt): Move to tmux dep
dep '.tmux.conf link' do
  def name
    '.tmux.conf'
  end
  requires 'dotfiles-repo', 'development dir'
  met? { dotfile_exists? name }
  meet { link_dotfile name }
end

dep 'dotfiles' do
  requires [
    'dotfiles-repo',
    '.aliases link',
    '.bash_profile link',
    '.bash_prompt link',
    '.docker_functions link',
    '.functions link',
    '.inputrc link',
    '.paths link',
    '.tmux-status.conf link',
    '.tmux.conf link',
  ]
end
