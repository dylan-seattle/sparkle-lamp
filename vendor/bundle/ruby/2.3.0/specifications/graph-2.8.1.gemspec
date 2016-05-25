# -*- encoding: utf-8 -*-
# stub: graph 2.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "graph"
  s.version = "2.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ryan Davis"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDPjCCAiagAwIBAgIBAzANBgkqhkiG9w0BAQUFADBFMRMwEQYDVQQDDApyeWFu\nZC1ydWJ5MRkwFwYKCZImiZPyLGQBGRYJemVuc3BpZGVyMRMwEQYKCZImiZPyLGQB\nGRYDY29tMB4XDTE1MDkxOTIwNTEyMloXDTE2MDkxODIwNTEyMlowRTETMBEGA1UE\nAwwKcnlhbmQtcnVieTEZMBcGCgmSJomT8ixkARkWCXplbnNwaWRlcjETMBEGCgmS\nJomT8ixkARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALda\nb9DCgK+627gPJkB6XfjZ1itoOQvpqH1EXScSaba9/S2VF22VYQbXU1xQXL/WzCkx\ntaCPaLmfYIaFcHHCSY4hYDJijRQkLxPeB3xbOfzfLoBDbjvx5JxgJxUjmGa7xhcT\noOvjtt5P8+GSK9zLzxQP0gVLS/D0FmoE44XuDr3iQkVS2ujU5zZL84mMNqNB1znh\nGiadM9GHRaDiaxuX0cIUBj19T01mVE2iymf9I6bEsiayK/n6QujtyCbTWsAS9Rqt\nqhtV7HJxNKuPj/JFH0D2cswvzznE/a5FOYO68g+YCuFi5L8wZuuM8zzdwjrWHqSV\ngBEfoTEGr7Zii72cx+sCAwEAAaM5MDcwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAw\nHQYDVR0OBBYEFEfFe9md/r/tj/Wmwpy+MI8d9k/hMA0GCSqGSIb3DQEBBQUAA4IB\nAQB+Hx8xUgrpZa4P8H8gR8zme5kISwQrG80MbpqJV6/G3/ZicRFhN5sjwu0uHGue\nbd9Cymf6oIRwHVarJux2M32T6bL07Hmi07w2QaPc3MnMKB/D46SRZ2JSSGPFRBTc\nSilobMRoGs/7B15uGFUEnNrCB/ltMqhwwSx1r++UQPfeySHEV9uqu03E5Vb7J37O\n2Er6PLXHRiYsIycD1LkMi6YnixdITRHmrqJYE2rsjaIfpIehiusVAPHkNf7qbpHq\nqx3h45R1CAsObX0SQDIT+rRbQrtKz1GHIZTOFYvEJjUY1XmRTZupD3CJ8Q7sDqSy\nNLq5jm1fq6Y9Uolu3RJbmycf\n-----END CERTIFICATE-----\n"]
  s.date = "2016-01-21"
  s.description = "Graph is a type of hash that outputs in graphviz's dot format. It\ncomes with a command-line interface that is easily pluggable.\n\nIt ships with plugins to graph dependencies and status of installed\nrubygems, rake tasks, homebrew ports, mac ports, and freebsd ports,\ncoloring leaf nodes blue, outdated nodes red, and outdated leaf nodes\npurple (red+blue).\n\nOSX quick tip: \n\n    % sudo gem install graph --development\n    % sudo brew install graphviz\n    % gem unpack graph\n    % cd graph*\n    % rake gallery\n    % open gallery/*.png"
  s.email = ["ryand-ruby@zenspider.com"]
  s.executables = ["graph"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "bin/graph"]
  s.homepage = "https://github.com/seattlerb/graph"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.txt"]
  s.rubygems_version = "2.5.1"
  s.summary = "Graph is a type of hash that outputs in graphviz's dot format"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, ["~> 5.8"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.14"])
    else
      s.add_dependency(%q<minitest>, ["~> 5.8"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe>, ["~> 3.14"])
    end
  else
    s.add_dependency(%q<minitest>, ["~> 5.8"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe>, ["~> 3.14"])
  end
end
