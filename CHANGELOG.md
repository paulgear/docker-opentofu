 Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
