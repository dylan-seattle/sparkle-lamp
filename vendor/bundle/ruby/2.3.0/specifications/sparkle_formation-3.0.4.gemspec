# -*- encoding: utf-8 -*-
# stub: sparkle_formation 3.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "sparkle_formation"
  s.version = "3.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2016-05-14"
  s.description = "Ruby DSL for programmatic orchestration API template generation"
  s.email = "chrisroberts.code@gmail.com"
  s.executables = ["generate_sparkle_docs"]
  s.files = ["bin/generate_sparkle_docs"]
  s.homepage = "http://github.com/heavywater/sparkle_formation"
  s.licenses = ["Apache-2.0"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1")
  s.rubygems_version = "2.5.1"
  s.summary = "Orchestration Template Generator"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<attribute_struct>, ["< 0.5", ">= 0.3.0"])
      s.add_runtime_dependency(%q<multi_json>, [">= 0"])
      s.add_runtime_dependency(%q<bogo>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
      s.add_development_dependency(%q<rubocop>, ["= 0.38.0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<redcarpet>, ["~> 2.0"])
      s.add_development_dependency(%q<github-markup>, [">= 0"])
    else
      s.add_dependency(%q<attribute_struct>, ["< 0.5", ">= 0.3.0"])
      s.add_dependency(%q<multi_json>, [">= 0"])
      s.add_dependency(%q<bogo>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rake>, ["~> 10"])
      s.add_dependency(%q<rubocop>, ["= 0.38.0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<redcarpet>, ["~> 2.0"])
      s.add_dependency(%q<github-markup>, [">= 0"])
    end
  else
    s.add_dependency(%q<attribute_struct>, ["< 0.5", ">= 0.3.0"])
    s.add_dependency(%q<multi_json>, [">= 0"])
    s.add_dependency(%q<bogo>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rake>, ["~> 10"])
    s.add_dependency(%q<rubocop>, ["= 0.38.0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<redcarpet>, ["~> 2.0"])
    s.add_dependency(%q<github-markup>, [">= 0"])
  end
end
