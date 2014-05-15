
def grab_server_pid
  f = File.open( './tmp/pids/server.pid', "rb" )
  result = f.read()
  f.close()

  result.to_i
end

namespace :ps do
  desc "Stop rails server"
  task :stop_server do
    pid = grab_server_pid
    Process.kill( 'INT', pid )
    puts "( #{pid} ) - Rails server stopped"
  end
end
