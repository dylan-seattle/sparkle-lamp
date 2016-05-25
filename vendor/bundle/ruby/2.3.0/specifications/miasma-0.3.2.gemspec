# -*- encoding: utf-8 -*-
# stub: miasma 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "miasma"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2016-03-10"
  s.description = "Smoggy API"
  s.email = "code@chrisroberts.org"
  s.homepage = "https://github.com/miasma-rb/miasma"
  s.licenses = ["Apache 2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "Smoggy API"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<http>, ["< 1.1", ">= 0.8.12"])
      s.add_runtime_dependency(%q<multi_json>, [">= 0"])
      s.add_runtime_dependency(%q<multi_xml>, [">= 0"])
      s.add_runtime_dependency(%q<xml-simple>, [">= 0"])
      s.add_runtime_dependency(%q<bogo>, ["< 1.0", ">= 0.2.2"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<http>, ["< 1.1", ">= 0.8.12"])
      s.add_dependency(%q<multi_json>, [">= 0"])
      s.add_dependency(%q<multi_xml>, [">= 0"])
      s.add_dependency(%q<xml-simple>, [">= 0"])
      s.add_dependency(%q<bogo>, ["< 1.0", ">= 0.2.2"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<http>, ["< 1.1", ">= 0.8.12"])
    s.add_dependency(%q<multi_json>, [">= 0"])
    s.add_dependency(%q<multi_xml>, [">= 0"])
    s.add_dependency(%q<xml-simple>, [">= 0"])
    s.add_dependency(%q<bogo>, ["< 1.0", ">= 0.2.2"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
