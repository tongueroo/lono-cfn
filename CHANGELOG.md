# Change Log

All notable changes to this project will be documented in this file.
This project *tries* to adhere to [Semantic Versioning](http://semver.org/), even before v1.0.

## [1.1.0]

- add lono-cfn diff
- rename lono-cfn preview

## [1.0.4]

- rename lono_cfn -> lono-cfn
- allow --help or -h at the end of the command

## [1.0.3]

- do not generate lono params with --no-lono option

## [1.0.2]

- fix delete stack command

## [1.0.1]

- update vendored lono-params 0.1.1

## [1.0.0]

- add lono-cfn preview
- fix edge cases and show helpful error messages when stacks are not in updatable statuses

## [0.0.8]

- vendor/lono-params

## [0.0.7]

- allow missing params file

## [0.0.6] add delete stack command

- add delete stack command

## [0.0.5] nicer error message

- nicer error message when theres no stack update to be perform

## [0.0.4] fix region support

- use region from ~/.aws/config file instead of specifying it

## [0.0.3] update cli help

- Update CLI help.

## [0.0.2] lono-cfn update

- `lono-cfn update` implemented.

## [0.0.1] Initial Release

- Initial release: `lono-cfn create`.
