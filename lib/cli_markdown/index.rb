module CliMarkdown
  class Index
    def initialize(cli_class, cli_name)
      @cli_class = cli_class
      @cli_name = cli_name
    end

    def path
      "docs/reference.md"
    end

    def command_list
      @cli_class.commands.keys.sort.map.each do |command_name|
        page = Page.new(
            cli_class: @cli_class,
            cli_name: @cli_name,
            command_name: command_name,
          )
        link = page.path.sub("docs/", "")
        # Example: [lono cfn]({% link _reference/lono-cfn.md %})
        "* [#{@cli_name} #{command_name}]({% link #{link} %})"
      end.join("\n")
    end

    def summary
      <<-EOL
Lono is a CloudFormation framework tool that helps you manage your templates. Lono handles the entire CloudFormation lifecycle. It starts with helping you develop your templates and helps you all the way to the infrastructure provisioning step.
EOL
    end

    def doc
      <<-EOL
---
title: CLI Reference
---
#{summary}
#{command_list}
EOL
    end
  end
end
