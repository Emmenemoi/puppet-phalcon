Puppet module for installing phalcon
====================================
Module will download and compile the phalcon extension for php. It requires the
puppi module from Alessandro Franceschi to download and compile the extension
at the moment.

Usage:
------
The version number must match the release tag in the [cphalcon repository](https://github.com/phalcon/cphalcon/releases "cphalcon repository").

* Install the latest version of phalcon

```puppet
    class {'phalcon':
    }
```

* Install a specific version

```puppet
    class {'phalcon':
        version => '1.3.1'
    }
```

Contribution:
-------------
Pull requests are welcome.


Supported environments
----------------------
This has currently been tested on Debian derivatives only at the moment
although it should most likely work on others. If you discover it is not
working for a specific version of an os then send in a pull request or open an
issue and I'll try to get to it.
