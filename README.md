# Lono Cfn

[![CircleCI](https://circleci.com/gh/tongueroo/lono-cfn.svg?style=svg)](https://circleci.com/gh/tongueroo/lono-cfn)

Wrapper cfn tool to quickly create CloudFormation stacks from [lono templates](https://github.com/tongueroo/lono) and [lono-params](https://github.com/tongueroo/lono-params) files.  Examples:

```bash
$ lono-cfn create my-stack-$(date +%s) --template my-template --params my-params
$ lono-cfn update my-stack-1493859659 --template my-template --params my-params
$ lono-cfn delete my-stack-1493859659 --sure
$ lono-cfn plan my-stack-1493859659 --template template-name --params params-name
```

The above command:

1. Generates the lono templates defined in the lono `config` and `template` files.
2. Generate a parameters file from the `params/my-params.txt`.
3. Launch the CloudFormation stack with those parameters.

This tool is meant to be used in conjuction with [lono](https://github.com/tongueroo/lono) but can also be used separately with the `--no-lono` flag, which skips the lono generation steps.

These blog posts cover both lono and lono-cfn:

* [Why Generate CloudFormation Templates with Lono](https://medium.com/boltops/why-generate-cloudformation-templates-with-lono-65b8ea5eb87d)
* [Generating CloudFormation Templates with Lono](https://medium.com/boltops/generating-cloudformation-templates-with-lono-4709afa1299b)
* [AutoScaling CloudFormation Template with Lono](https://medium.com/boltops/autoscaling-cloudformation-template-with-lono-3dc520480c5f)
* [CloudFormation Tools: lono, lono-params and lono-cfn Together
](https://medium.com/boltops/cloudformation-tools-lono-lono-params-and-lono-cfn-play-together-620af51e616)
* [AWS CloudFormation dry-run with lono-cfn plan](https://medium.com/boltops/aws-cloudformation-dry-run-with-lono-cfn-plan-2a1e0f80d13c)

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

### lono-cfn create

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

### lono-cfn update

To update stacks you can use `lono-cfn update`:

```
$ lono-cfn update my-stack --template template-name --params params-name
```

By default the update command will display a preview of the stack changes before applying the update and prompt to check if you are sure.  If you want to bypass the are you sure prompt, use the `--sure` option.

```
$ lono-cfn update my-stack --template template-name --params params-name --sure
```

### lono-cfn delete

```
$ lono-cfn delete my-stack --sure
```

### lono-cfn plan

If you want to see the CloudFormation plan without updating the stack you can also use the `lono-cfn plan` command.

```
$ lono-cfn plan example --template single_instance --params single_instance
Using template: output/single_instance.yml
Using parameters: params/single_instance.txt
Generating CloudFormation templates:
  ./output/single_instance.yml
Params file generated for example at ./output/params/example.json
Generating CloudFormation Change Set for plan.....
CloudFormation plan for 'example' stack update. Changes:
Remove AWS::Route53::RecordSet: DnsRecord testsubdomain.sub.tongueroo.com
$
```


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
