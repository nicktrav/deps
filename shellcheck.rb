dep 'shellcheck', :version do
  requires 'curl', 'tar.apt'
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
