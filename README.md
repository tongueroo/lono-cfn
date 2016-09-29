# Lono Cfn

Wrapper cfn tool to quickly create CloudFormation stacks from lono templates and params files.  

This project is a WIP as only the create command is available right now.

```bash
$ bundle exec lono-cfn create my-stack-$(date +%s) --template my-template --params my-params
```

The above command:

1. Generates the lono templates defined in the lono config files.
2. Generate a parameters file from the params/my-params.txt.
3. Launch the CloudFormation stack with those parameters.

This tool is meant to be used in conjuction with [lono](https://github.com/tongueroo/lono) but can also be used separately with the `--no-lono` flag, which skips the `lono generate` call.

## Installation

Add this line to your application's Gemfile:

    gem 'lono-cfn'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lono-cfn

## Usage

Provided that you are in a lono project and have a `my-stack` lono template definition.  To create a stack you can simply run:

```
$ lono-cfn create my-stack
```

The above command will generate and use the template in output/my-stack.json and parameters in params/my-stack.txt.  The template defaults by convention to the name of the stack.  The params defaults by convention to the name of the template in turn.  The conventions allows the command to be a very nice short command that can be easily remembered.  Both conventions can be overridden.

## More About Conventions

* stack - This is a required parameter and is the passed in from the CLI as the first parameter.
* template - By convention matches the stack name but can be overriden with `--template`.
* params = By convention matches the template name but can be overriden with `--params`.

Here are examples of overriding the template and params name conventions.

```
$ lono-cfn create my-stack --template different-name1
```

The template that will be use is output/different-name1.json and the parameters will use params/different-name1.json.

```
$ lono-cfn create my-stack --params different-name2
```

The template that will be use is output/different-name2.json and the parameters will use params/different-name2.json.

```
$ lono-cfn create my-stack --template different-name3 --params different-name4
```

The template that will be use is output/different-name3.json and the parameters will use params/different-name4.json.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
