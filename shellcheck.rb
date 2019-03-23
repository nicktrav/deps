dep 'shellcheck', :version do
  on :debian do
    requires 'shellcheck.debian'
  end

  on :osx do
    requires 'shellcheck.osx.bin'
  end
end

dep 'shellcheck.debian', :version do
  requires 'curl', 'tar.bin'
  version.default!('0.6.0')
  met? { shell? "shellcheck --version | grep #{version}" }
  meet do
    tarball="shellcheck-v#{version}.linux.x86_64.tar.xz"
    url="https://storage.googleapis.com/shellcheck/#{tarball}"

    shell <<-HERE
      cd /tmp && rm -rf shellcheck* && \
      curl -O -L #{url} && \
      tar -xJf #{tarball} && \
      sudo cp "shellcheck-v#{version}/shellcheck" /usr/local/bin/ && \
      rm -rf #{tarball} shellcheck*
    HERE
  end
end

dep 'shellcheck.osx.bin' do
  provides "shellcheck"
  installs {
    via :brew, 'shellcheck'
  }
end
