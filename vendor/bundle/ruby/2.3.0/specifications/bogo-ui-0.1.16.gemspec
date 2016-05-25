# -*- encoding: utf-8 -*-
# stub: bogo-ui 0.1.16 ruby lib

Gem::Specification.new do |s|
  s.name = "bogo-ui"
  s.version = "0.1.16"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2016-03-10"
  s.description = "UI Helper libraries"
  s.email = "code@chrisroberts.org"
  s.homepage = "https://github.com/spox/bogo-ui"
  s.licenses = ["Apache 2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "UI Helper libraries"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bogo>, [">= 0"])
      s.add_runtime_dependency(%q<command_line_reporter>, [">= 0"])
      s.add_runtime_dependency(%q<paint>, [">= 0"])
    else
      s.add_dependency(%q<bogo>, [">= 0"])
      s.add_dependency(%q<command_line_reporter>, [">= 0"])
      s.add_dependency(%q<paint>, [">= 0"])
    end
  else
    s.add_dependency(%q<bogo>, [">= 0"])
    s.add_dependency(%q<command_line_reporter>, [">= 0"])
    s.add_dependency(%q<paint>, [">= 0"])
  end
end
