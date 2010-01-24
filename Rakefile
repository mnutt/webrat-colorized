begin
  require 'bones'
  Bones.setup
rescue LoadError
  begin
    load 'tasks/setup.rb'
  rescue LoadError
    raise RuntimeError, '### please install the "bones" gem ###'
  end
end

ensure_in_path 'lib'
require 'webrat_colorized'

task :default => 'spec:run'

PROJ.name = 'webrat-colorized'
PROJ.authors = 'Michael Nutt'
PROJ.email = 'michael@nuttnet.net'
PROJ.url = 'http://github.com/mnutt/webrat-colorized'
PROJ.version = WebratColorized::VERSION
PROJ.rubyforge.name = 'webrat-colorized'

PROJ.spec.opts << '--color'

# EOF
