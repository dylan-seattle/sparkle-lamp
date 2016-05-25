---
title: "Configuration"
weight: 2
anchors:
  - title: "sfn-based"
    url: "#sfn-based"
  - title: "knife-based"
    url: "#knife-based"
  - title: "Generate sfn configuration"
    url: "#generate-sfn-configuration"
  - title: "configuration-options"
    url: "#configuration-options"
---


## Configuration

The configuration location of the `sfn` command is
dependent on the invocation method used. Since the
CLI application can be invoked as a standalone
application, or as a knife subcommand, two styles
of configuration are supported.

### `sfn`-based

Configuration for the `sfn` standalone application
utilizes the bogo-config library. This allows the
configuration file to be defined in multiple formats.
Supported formats:

* Ruby
* YAML
* JSON
* XML

The configuration is contained within a file named
`.sfn`.

#### Generate sfn configuration

The `sfn` command provides a `conf` subcommand. By
default this command will display current local
configuration values. It can also be used to generate
an initial configuration file which can then be
customized:

~~~
$ sfn conf --generate
~~~

This will create a new `.sfn` file in the working directory.

### `knife`-based

The `sfn` application includes a plugin for the
[knife][knife] CLI tool. Configuration can be
provided in the `.chef/knife.rb` file and commands
can be accessed via:

~~~
$ knife sparkleformation --help
~~~

[knife]: https://docs.chef.io/knife.html
