# -*- encoding: utf-8 -*-
# stub: paint 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "paint"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2016-01-03"
  s.description = "Terminal painter: No string extensions / 256 color support / effect support. Usage: Paint['string', :red, :bright]"
  s.email = "mail@janlelis.de"
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG.rdoc", "MIT-LICENSE.txt"]
  s.files = ["CHANGELOG.rdoc", "MIT-LICENSE.txt", "README.rdoc"]
  s.homepage = "https://github.com/janlelis/paint"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.requirements = ["Windows: ansicon (https://github.com/adoxa/ansicon) or ConEmu (http://code.google.com/p/conemu-maximus5)"]
  s.rubygems_version = "2.5.1"
  s.summary = "Terminal painter!"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 3.2"])
      s.add_development_dependency(%q<rake>, ["~> 10.4"])
      s.add_development_dependency(%q<benchmark-ips>, ["~> 2.3"])
      s.add_development_dependency(%q<rainbow>, ["~> 2.0"])
      s.add_development_dependency(%q<term-ansicolor>, ["~> 1.3"])
      s.add_development_dependency(%q<ansi>, ["~> 1.5"])
      s.add_development_dependency(%q<hansi>, ["~> 0.1"])
      s.add_development_dependency(%q<pastel>, ["~> 0.5"])
    else
      s.add_dependency(%q<rspec>, ["~> 3.2"])
      s.add_dependency(%q<rake>, ["~> 10.4"])
      s.add_dependency(%q<benchmark-ips>, ["~> 2.3"])
      s.add_dependency(%q<rainbow>, ["~> 2.0"])
      s.add_dependency(%q<term-ansicolor>, ["~> 1.3"])
      s.add_dependency(%q<ansi>, ["~> 1.5"])
      s.add_dependency(%q<hansi>, ["~> 0.1"])
      s.add_dependency(%q<pastel>, ["~> 0.5"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3.2"])
    s.add_dependency(%q<rake>, ["~> 10.4"])
    s.add_dependency(%q<benchmark-ips>, ["~> 2.3"])
    s.add_dependency(%q<rainbow>, ["~> 2.0"])
    s.add_dependency(%q<term-ansicolor>, ["~> 1.3"])
    s.add_dependency(%q<ansi>, ["~> 1.5"])
    s.add_dependency(%q<hansi>, ["~> 0.1"])
    s.add_dependency(%q<pastel>, ["~> 0.5"])
  end
end
