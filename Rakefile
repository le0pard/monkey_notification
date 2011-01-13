require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'


desc 'Default: run unit tests.'
task :default => :test

desc 'Test the rw_mdn plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the rw_mdn plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MonkeyNotification'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

PKG_FILES = FileList[
  '[a-zA-Z]*',
  'lib/**/*.rb'
]

spec = Gem::Specification.new do |s|
  s.name          = "monkey_notification"
  s.version       = "0.0.3"
  s.author        = "Alexey Vasileiv"
  s.email         = "alexey.vasiliev@railsware.com"
  s.homepage      = "http://railsware.com/"
  s.platform      = Gem::Platform::RUBY
  s.summary       = "Monkey Notification on Deployment"
  s.description   = "Railsware Monkey Notification Gem"
  s.files         = PKG_FILES.to_a
  s.require_path  = "lib"
  s.has_rdoc      = false
  s.extra_rdoc_files = ["README"]
  s.add_runtime_dependency("activesupport")
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end