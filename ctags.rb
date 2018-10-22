dep 'ctags', :version  do
  requires 'git.apt', 'make.apt', 'autoconf.apt', 'pkg-config.apt'
  version.default!('836df9df')
  met? { in_path? "ctags >= #{version}" }
  meet {
    shell <<-HERE
      rm -rf /tmp/ctags && \
      git clone https://github.com/universal-ctags/ctags.git /tmp/ctags && \
      cd /tmp/ctags && \
      git checkout #{version} && \
      ./autogen.sh && \
      ./configure && \
      make && sudo make install && \
      rm -rf /tmp/ctags
    HERE
  }
end
