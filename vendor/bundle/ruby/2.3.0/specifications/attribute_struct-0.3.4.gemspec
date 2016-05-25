# -*- encoding: utf-8 -*-
# stub: attribute_struct 0.3.4 ruby lib

Gem::Specification.new do |s|
  s.name = "attribute_struct"
  s.version = "0.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2016-03-10"
  s.description = "Attribute structures"
  s.email = "chrisroberts.code@gmail.com"
  s.homepage = "http://github.com/chrisroberts/attribute_struct"
  s.licenses = ["Apache 2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "Attribute structures"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bogo>, ["< 0.3.0", ">= 0.1.31"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<bogo>, ["< 0.3.0", ">= 0.1.31"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<bogo>, ["< 0.3.0", ">= 0.1.31"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
