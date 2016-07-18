# iedriverserver-helper

[![Build status](https://api.travis-ci.org/bergholdt/iedriverserver-helper.svg)](https://travis-ci.org/bergholdt/iedriverserver-helper)

Easy installation and use of [InternetExplorerDriver](https://github.com/SeleniumHQ/selenium/wiki/InternetExplorerDriver) selenium webdriver adapter.

* [http://github.com/bergholdt/iedriverserver-helper](http://github.com/bergholdt/iedriverserver-helper)


# Description

`iedriverserver-helper` installs an executable, `iedriverserver`, in your
gem path.

This script will, if necessary, download the appropriate binary for
your platform and install it into `~/.iedriverserver-helper`, then exec
it. Easy peasy!


# Usage

If you're using Bundler and Capybara, it's as easy as:

    # Gemfile
    gem "iedriverserver-helper"

then, in your specs:

    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :ie)
    end


# Updating iedriverserver

If you'd like to force-upgrade to the latest version of iedriverserver,
run the script `iedriverserver-update` that also comes packaged with
this gem.


# Support

The code lives at
[http://github.com/bergholdt/iedriverserver-helper](http://github.com/bergholdt/iedriverserver-helper).
Open a Github Issue, or send a pull request! Thanks! You're the best.


# License

MIT licensed, see LICENSE.txt for full details.


# Credit

This gem is heavy inspired by http://github.com/flavorjones/chromedriver-helper
