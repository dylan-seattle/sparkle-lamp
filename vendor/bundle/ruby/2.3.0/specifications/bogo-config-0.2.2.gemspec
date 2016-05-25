# -*- encoding: utf-8 -*-
# stub: bogo-config 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "bogo-config"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2016-04-05"
  s.description = "Configuration helper library"
  s.email = "code@chrisroberts.org"
  s.homepage = "https://github.com/spox/bogo-config"
  s.licenses = ["Apache 2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "Configuration helper library"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bogo>, ["< 1.0", ">= 0.1.4"])
      s.add_runtime_dependency(%q<multi_json>, [">= 0"])
      s.add_runtime_dependency(%q<multi_xml>, [">= 0"])
      s.add_runtime_dependency(%q<attribute_struct>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
    else
      s.add_dependency(%q<bogo>, ["< 1.0", ">= 0.1.4"])
      s.add_dependency(%q<multi_json>, [">= 0"])
      s.add_dependency(%q<multi_xml>, [">= 0"])
      s.add_dependency(%q<attribute_struct>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rake>, ["~> 10"])
    end
  else
    s.add_dependency(%q<bogo>, ["< 1.0", ">= 0.1.4"])
    s.add_dependency(%q<multi_json>, [">= 0"])
    s.add_dependency(%q<multi_xml>, [">= 0"])
    s.add_dependency(%q<attribute_struct>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rake>, ["~> 10"])
  end
end
