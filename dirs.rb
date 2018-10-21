dep 'development dir' do
  def dir
    '~/Development'.p
  end
  met? { dir.exists? }
  meet { shell "mkdir #{dir}" }
end
