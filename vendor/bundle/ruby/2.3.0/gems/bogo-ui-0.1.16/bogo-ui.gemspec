$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'bogo-ui/version'
Gem::Specification.new do |s|
  s.name = 'bogo-ui'
  s.version = Bogo::Ui::VERSION.version
  s.summary = 'UI Helper libraries'
  s.author = 'Chris Roberts'
  s.email = 'code@chrisroberts.org'
  s.homepage = 'https://github.com/spox/bogo-ui'
  s.description = 'UI Helper libraries'
  s.require_path = 'lib'
  s.license = 'Apache 2.0'
  s.add_dependency 'bogo'
  s.add_dependency 'command_line_reporter'
  s.add_dependency 'paint'
  s.files = Dir['lib/**/*'] + %w(bogo-ui.gemspec README.md CHANGELOG.md CONTRIBUTING.md LICENSE)
end
