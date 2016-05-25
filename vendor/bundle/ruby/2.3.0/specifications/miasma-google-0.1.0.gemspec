# -*- encoding: utf-8 -*-
# stub: miasma-google 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "miasma-google"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2016-04-20"
  s.description = "Smoggy Google API"
  s.email = "code@chrisroberts.org"
  s.homepage = "https://github.com/miasma-rb/miasma-google"
  s.licenses = ["Apache 2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "Smoggy Google API"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<miasma>, [">= 0.2.12"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<psych>, [">= 2.0.8"])
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
    else
      s.add_dependency(%q<miasma>, [">= 0.2.12"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<psych>, [">= 2.0.8"])
      s.add_dependency(%q<mime-types>, [">= 0"])
    end
  else
    s.add_dependency(%q<miasma>, [">= 0.2.12"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<psych>, [">= 2.0.8"])
    s.add_dependency(%q<mime-types>, [">= 0"])
  end
end
