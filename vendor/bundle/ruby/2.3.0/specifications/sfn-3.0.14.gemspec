# -*- encoding: utf-8 -*-
# stub: sfn 3.0.14 ruby lib

Gem::Specification.new do |s|
  s.name = "sfn"
  s.version = "3.0.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Roberts"]
  s.date = "2016-05-20"
  s.description = "SparkleFormation CLI"
  s.email = "code@chrisroberts.org"
  s.executables = ["sfn"]
  s.files = ["bin/sfn"]
  s.homepage = "http://github.com/sparkleformation/sfn"
  s.licenses = ["Apache-2.0"]
  s.rubygems_version = "2.5.1"
  s.summary = "SparkleFormation CLI"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bogo-cli>, ["< 0.4", ">= 0.2.5"])
      s.add_runtime_dependency(%q<bogo-ui>, ["< 0.4", ">= 0.1.13"])
      s.add_runtime_dependency(%q<miasma>, ["< 0.4", ">= 0.3.0"])
      s.add_runtime_dependency(%q<miasma-aws>, ["< 0.4", ">= 0.3.3"])
      s.add_runtime_dependency(%q<miasma-azure>, ["< 0.3", ">= 0.1.0"])
      s.add_runtime_dependency(%q<miasma-open-stack>, ["< 0.3", ">= 0.1.0"])
      s.add_runtime_dependency(%q<miasma-rackspace>, ["< 0.3", ">= 0.1.0"])
      s.add_runtime_dependency(%q<miasma-google>, ["< 0.3", ">= 0.1.0"])
      s.add_runtime_dependency(%q<jmespath>, [">= 0"])
      s.add_runtime_dependency(%q<net-ssh>, [">= 0"])
      s.add_runtime_dependency(%q<sparkle_formation>, ["< 4", ">= 3.0.3"])
      s.add_runtime_dependency(%q<hashdiff>, ["~> 0.2.2"])
      s.add_runtime_dependency(%q<graph>, ["~> 2.8.1"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<bogo-cli>, ["< 0.4", ">= 0.2.5"])
      s.add_dependency(%q<bogo-ui>, ["< 0.4", ">= 0.1.13"])
      s.add_dependency(%q<miasma>, ["< 0.4", ">= 0.3.0"])
      s.add_dependency(%q<miasma-aws>, ["< 0.4", ">= 0.3.3"])
      s.add_dependency(%q<miasma-azure>, ["< 0.3", ">= 0.1.0"])
      s.add_dependency(%q<miasma-open-stack>, ["< 0.3", ">= 0.1.0"])
      s.add_dependency(%q<miasma-rackspace>, ["< 0.3", ">= 0.1.0"])
      s.add_dependency(%q<miasma-google>, ["< 0.3", ">= 0.1.0"])
      s.add_dependency(%q<jmespath>, [">= 0"])
      s.add_dependency(%q<net-ssh>, [">= 0"])
      s.add_dependency(%q<sparkle_formation>, ["< 4", ">= 3.0.3"])
      s.add_dependency(%q<hashdiff>, ["~> 0.2.2"])
      s.add_dependency(%q<graph>, ["~> 2.8.1"])
      s.add_dependency(%q<rake>, ["~> 10"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<bogo-cli>, ["< 0.4", ">= 0.2.5"])
    s.add_dependency(%q<bogo-ui>, ["< 0.4", ">= 0.1.13"])
    s.add_dependency(%q<miasma>, ["< 0.4", ">= 0.3.0"])
    s.add_dependency(%q<miasma-aws>, ["< 0.4", ">= 0.3.3"])
    s.add_dependency(%q<miasma-azure>, ["< 0.3", ">= 0.1.0"])
    s.add_dependency(%q<miasma-open-stack>, ["< 0.3", ">= 0.1.0"])
    s.add_dependency(%q<miasma-rackspace>, ["< 0.3", ">= 0.1.0"])
    s.add_dependency(%q<miasma-google>, ["< 0.3", ">= 0.1.0"])
    s.add_dependency(%q<jmespath>, [">= 0"])
    s.add_dependency(%q<net-ssh>, [">= 0"])
    s.add_dependency(%q<sparkle_formation>, ["< 4", ">= 3.0.3"])
    s.add_dependency(%q<hashdiff>, ["~> 0.2.2"])
    s.add_dependency(%q<graph>, ["~> 2.8.1"])
    s.add_dependency(%q<rake>, ["~> 10"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end
