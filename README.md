# Dustcart

[![CircleCI](https://circleci.com/gh/tamano/dustcart.svg?style=svg)](https://circleci.com/gh/tamano/dustcart)
[![Code Climate](https://codeclimate.com/github/tamano/dustcart/badges/gpa.svg)](https://codeclimate.com/github/tamano/dustcart)
[![Test Coverage](https://codeclimate.com/github/tamano/dustcart/badges/coverage.svg)](https://codeclimate.com/github/tamano/dustcart/coverage)
[![Issue Count](https://codeclimate.com/github/tamano/dustcart/badges/issue_count.svg)](https://codeclimate.com/github/tamano/dustcart)

Dustcart is simple server backup tool inspired by [backup](https://github.com/backup/backup)

## Installation

Install it yourself as:

    $ gem install dustcart

## Basic usage

1. Create your configuration file.
    - The file instructs which file/directory to backup and to which S3 bucket.
    - This file would contain sensitive information (such as AWS credential), so it should be have file mode `600`.
    - Sample is [here](https://github.com/tamano/dustcart/blob/master/spec/sample_instructions/backup_all.rb)
2. Kick command.


    $ dustcart exec -f YOUR_CONFIGURATION_FILE

- `-f YOUR_CONFIGURATION_FILE` can be omitted. In that case, `~/.dustcart/default.rb` will be used.

## Details

Please read the [sample file](https://github.com/tamano/dustcart/blob/master/spec/sample_instructions/backup_all.rb).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tamano/dustcart.

