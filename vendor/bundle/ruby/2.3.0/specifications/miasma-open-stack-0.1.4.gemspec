# -*- encoding: utf-8 -*-
# stub: miasma-open-stack 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "miasma-open-stack"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2015-12-29"
  s.description = "Smoggy OpenStack API"
  s.email = "code@chrisroberts.org"
  s.homepage = "https://github.com/miasma-rb/miasma-open-stack"
  s.licenses = ["Apache 2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "Smoggy OpenStack API"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<miasma>, [">= 0.2.12"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<psych>, [">= 2.0.8"])
    else
      s.add_dependency(%q<miasma>, [">= 0.2.12"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<psych>, [">= 2.0.8"])
    end
  else
    s.add_dependency(%q<miasma>, [">= 0.2.12"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<psych>, [">= 2.0.8"])
  end
end
