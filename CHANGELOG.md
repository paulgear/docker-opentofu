 Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [10.0.0] - 2021-06-09
### Breaking
- Upgraded terraform to 1.0.0


## [9.0.0] - 2021-04-15
### Breaking
- Upgraded terraform to 0.15.0

### Changed
- Upgraded terraform-docs to 0.12.1
- Upgraded aws cli to 1.19.52
### Added
- tree

## [8.4.0] - 2021-03-29
### Added
- zip utility
## [8.3.0] - 2021-02-09
### Changed
- Upgraded terraform to 0.14.6
- Upgraded terraform-docs to 0.10.1
- Added python libraries for gitlab terraform provider
## [8.2.0] - 2021-01-21
### Changed
- Upgraded terraform to 0.14.5
## [8.1.0] - 2020-12-10
### Changed
- Upgraded terraform to 0.14.2
## [8.0.0] - 2020-12-07
### Breaking
- Upgraded terraform to 0.14.0
## [7.1.0] - 2020-11-06
### Changed
- Upgraded terraform to 0.13.5

## [7.0.0] - 2020-08-17
### Breaking
- Upgraded terraform to 0.13.0

### Changed
- Upgraded awscli to 1.18.120

## [6.2.0] - 2020-04-24
### Changed
- Upgraded awscli to 1.18.45
- Upgraded terraform-docs to 0.9.1

## [6.1.0] - 2020-03-31
### Changed
- Upgraded terraform to 0.12.24
- Upgraded awscli to 1.18.32

## [6.0.0] - 2020-02-17
### Breaking
- Removed remaining packages that were expected to be used in shells
- Upgrade to Alpine 3.11
- Introduce new CICD process
- Removed git-chglog
- Switch entrypont from bash to terraform

### Changed
- Upgrade Terraform/AWS CLI/Terraform-docs

## [5.3.0] - 2019-10-24
### Changed
- Upgraded terraform to 0.12.10

## [5.2.0] - 2019-09-30
### Changed
- Upgraded terraform to 0.12.9

## [5.1.0] - 2019-09-05
### Removed
- Removed all shell scripts including PS1 prompts

## [5.0.0] - 2019-08-09
### Breaking
- Removed terraform-docs as it doesnt support 0.12
### Changed
- Upgraded terraform to 0.12.6
- Upgraded awscli to 1.16.214

## [4.3.0] - 2019-07-10
### Changed
- Upgraded terraform to 0.12.3

## [4.2.0] - 2019-06-25
### Changed
- Upgraded terraform to 0.12.2

## [4.1.0] - 2019-06-09
### Changed
- Upgraded terraform to 0.12.1

## [4.0.0] - 2019-06-05
### Breaking
- Upgraded terraform to 0.12.0

## [3.0.0] - 2019-04-24
### Breaking
- Removed terraform as the entrypoint.

### Added
- Added PS1 prompt that shows AWS and Terraform Workspace details
- Added reauth helper script

### Updated
- terraform to 0.11.13
- awscli to 1.16.144

### Removed
- g++ as it shouldnt be required now we arent building terraform

## [2.0.0] - 2019-03-01
### Added
- terraform-docs
- git-chglog

### Changed
- Upgraded Python2 to Python3
- Now using the precompiled release of terraform rather than compiling from source
