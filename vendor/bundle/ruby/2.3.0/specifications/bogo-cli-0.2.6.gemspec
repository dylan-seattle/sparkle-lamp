# -*- encoding: utf-8 -*-
# stub: bogo-cli 0.2.6 ruby lib

Gem::Specification.new do |s|
  s.name = "bogo-cli"
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2016-03-28"
  s.description = "CLI Helper libraries"
  s.email = "code@chrisroberts.org"
  s.homepage = "https://github.com/spox/bogo-cli"
  s.licenses = ["Apache 2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "CLI Helper libraries"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bogo>, ["< 0.6", ">= 0.1.6"])
      s.add_runtime_dependency(%q<bogo-config>, ["< 0.5", ">= 0.1.15"])
      s.add_runtime_dependency(%q<bogo-ui>, [">= 0"])
      s.add_runtime_dependency(%q<slop>, ["~> 3"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<bogo>, ["< 0.6", ">= 0.1.6"])
      s.add_dependency(%q<bogo-config>, ["< 0.5", ">= 0.1.15"])
      s.add_dependency(%q<bogo-ui>, [">= 0"])
      s.add_dependency(%q<slop>, ["~> 3"])
      s.add_dependency(%q<rake>, ["~> 10"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<bogo>, ["< 0.6", ">= 0.1.6"])
    s.add_dependency(%q<bogo-config>, ["< 0.5", ">= 0.1.15"])
    s.add_dependency(%q<bogo-ui>, [">= 0"])
    s.add_dependency(%q<slop>, ["~> 3"])
    s.add_dependency(%q<rake>, ["~> 10"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
