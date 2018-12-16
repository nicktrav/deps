dep 'deps-dir' do
  def dir
    "~/Development/deps"
  end
  requires 'development dir'
  met? { dir.p.exist? }
  meet {
    shell "ln -s ~/.babushka/deps #{dir}"
  }
end
