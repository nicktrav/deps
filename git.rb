dep 'git.local', :version do
  version.default!('2.11.0')
  requires_when_unmet 'git.bin.local'.with(version)
  met? { in_path? "git >= #{version}" }
end

dep 'git.bin.local', :version do
  version.default!('2.11.0')
  installs {
    via :apt, 'git-core'
  }
  provides "git >= #{version}"
end
