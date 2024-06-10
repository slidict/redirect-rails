# Redirect::Rails

This gem provides 302 redirect functionality in rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redirect-rails'
```

And then execute:

```
$ bin/rails redirect:install
```
## Usage

List the correspondence of the paths you want to redirect in config/redirect.yml."

## paths

In the `config/redirect.yml` file, you can write redirect settings as follows.

```
paths:
  /regexp/([^/]+): /redirected/regexp/<%= $1 %>
  /static/failuer: /static/true
```

## Contributing

- No test code yet. Pull requests are welcome.

-Bug reports and pull requests are welcome on GitHub at https://github.com/slidict/redirect-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/slidict/redirect-rails/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Redirect::Rails project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/slidict/redirect-rails/blob/main/CODE_OF_CONDUCT.md).
