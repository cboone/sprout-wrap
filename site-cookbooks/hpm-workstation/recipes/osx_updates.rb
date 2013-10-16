run_unless_marker_file_exists "osx_updates-#{Date.today}" do
  execute 'install all available OS X updates from Apple' do
    command 'softwareupdate -ia'
  end

  execute 'turn on automatic checking for OS X updates' do
    command 'softwareupdate --schedule on'
  end
end
