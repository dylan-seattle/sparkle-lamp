# Bogo UI

Simple CLI output helpers.

## Bogo::Ui

Output formatted information to the CLI.

```ruby
require 'bogo-ui'

ui = Bogo::Ui.new(
  :app_name => 'TestApp'
)

ui.info 'This is information'
ui.warn 'This is a warning'
ui.error 'This is an error'

ui.info "This is information with #{ui.color('color', :bold, :green)}"

result = ui.ask('Type a word')
ui.info "You provided: #{result}"
```

## Bogo::Ui::Table

This is a table helper. Under the hood it uses the Command Line Reporter
with a few modifications. Direct usage:

```ruby
require 'bogo-ui'

ui = Bogo::Ui.new(:app_name => 'TestApp')
Bogo::Ui::Table.new(ui) do
  table do
    row do
      column 'Name'
      column 'Age'
    end
    row do
      column 'me'
      column '100'
    end
  end
end.display
```

This helper allows for appending data to an existing table. Useful
for when polling for updates and wanting to keep the existing table
structure:

```ruby
require 'bogo-ui'

ui = Bogo::Ui.new(:app_name => 'TestApp')
tbl = Bogo::Ui::Table.new(ui) do
  table do
    row do
      column 'Name'
      column 'Age'
    end
    row do
      column 'me'
      column '100'
    end
  end
end

tbl.display

tbl.update do
  row do
    column 'you'
    column '50'
  end
end

tbl.display
```

## Info
* Repository: https://github.com/spox/bogo-ui
* Command Line Reporter: https://github.com/wbailey/command_line_reporter