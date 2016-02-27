# grape-goliath-boilerplate


It is a boilerplate Heroku ready to create your REST API using [Grape](https://github.com/intridea/grape) and [Goliath](https://github.com/postrank-labs/goliath).

This project was based on [djones](https://github.com/djones/grape-goliath-example) and [wulftone](https://github.com/wulftone/goliath-heroku-postgres-example) work. Thank you guys!!


## Overview

Nowdays almost every thing use a API. So, this is starter template for writing APIs using the amazing [Grape](https://github.com/intridea/grape) micro-framework. Moreover ActiveRecord, Rspec some rake tasks and a lot of things that you use in a Rails app you can use here too.



### Directories

    * app: your API lives here it is divided in another small pieces
    * app/apis: where you write your endpoints (you don't need define a route, just create a endpoint).
    * app/models: ActiveRecord models
    * app/helpers:
    * app/parsers: if you need some thing more to create your models
    * app/policies: if you use thin models you can put some logic here
    * app/queries: if you have complex queries, you can put it in a query object
    * app/services: do the hard work
    * app/views: define how responses will be rendered with [Rabl](https://github.com/nesquena/rabl)
    * bin: generators to help create resources (use ./gen to help)
    * config: a lot of setup
    * db: migrations and scheme
    * lib: if you want some rake task, that's the place
    * spec: specs and factories

## Run

After download project

>>  bundle install

>>  rake db:create

>> foreman start -f Procfile.dev



## TODO

* A lot of things
* Rake tasks are crashing cause goliath is required
* Benchmarks

## Contributing

Bug reports and pull requests are welcome.

## License
[MIT ©](https://github.com/cadicallegari/grape-goliath-boilerplate/blob/master/LICENSE)
