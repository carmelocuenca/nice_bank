require 'service_manager'

ServiceManager.define_service 'transaction_processor' do |service|
  service.start_cmd = 'ruby lib/transaction_processor.rb'
  service.loaded_cue = /ready/
  service.cwd = Dir.pwd
  service.pid_file = 'transaction_processor.pid'
end