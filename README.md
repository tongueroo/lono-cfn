# Lono Cfn

[![CircleCI](https://circleci.com/gh/tongueroo/lono-cfn.svg?style=svg)](https://circleci.com/gh/tongueroo/lono-cfn)

Wrapper cfn tool to quickly create CloudFormation stacks from [lono templates](https://github.com/tongueroo/lono) and [lono-params](https://github.com/tongueroo/lono-params) files.  Example:

```bash
$ lono-cfn create my-stack-$(date +%s) --template my-template --params my-params
$ lono-cfn update my-stack-1493859659 --template my-template --params my-params
$ lono-cfn delete my-stack-1493859659
```

The above command:

1. Generates the lono templates defined in the lono `config` and `template` files.
2. Generate a parameters file from the `params/my-params.txt`.
3. Launch the CloudFormation stack with those parameters.

This tool is meant to be used in conjuction with [lono](https://github.com/tongueroo/lono) but can also be used separately with the `--no-lono` flag, which skips the `lono generate` step.

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

The above command will generate and use the template in `output/my-stack.json` and parameters in `params/my-stack.txt`.

### Conventions

The template by convention defaults to the name of the stack.  In turn, the params by convention defaults to the name of the template.

* stack - This is a required parameter and is the CLI first parameter.
* template - By convention matches the stack name but can be overriden with `--template`.
* params - By convention matches the template name but can be overriden with `--params`.

The conventions allows the command to be a very nice short command that can be easily remembered.  For example, these 2 commands are the same:

Long form:

```
$ lono-cfn create my-stack --template my-stack --params --my-stack
```

Short form:

```
$ lono-cfn create my-stack
```


Both template and params conventions can be overridden.  Here are examples of overriding the template and params name conventions.

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

## Developing

```bash
$ git clone git@github.com:yourfork/lono-cfn.git
$ git submodule sync
$ git submodule update --init
```

## Related Projects

* [lono](https://github.com/tongueroo/lono) - Lono is a CloudFormation Template generator.  Lono generates CloudFormation templates based on ERB ruby templates.
* [lono-params](https://github.com/tongueroo/lono-params) - Tool to generate a CloudFormation parameters json formatted file from a simplier env like file.

ith
