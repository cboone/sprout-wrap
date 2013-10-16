name = node['hpm']['machine_name']

["scutil --set ComputerName #{name}",
 "scutil --set LocalHostName #{name}",
 "scutil --set HostName #{name}",
 "hostname #{name}",
 "diskutil rename / #{name}"].each do |host_cmd|
  execute host_cmd
end
