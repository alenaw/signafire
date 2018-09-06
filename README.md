# Signafire Take Home

This API consists of 3 models (user, elastic_index, elastic_result), 2 databases
(SQLite and Elasticsearch) and 2 controllers. The user and elastic_index resources
are stored in SQLite and are associated through a join table. The elastic_result
resources are representations of documents from Elasticsearch.

## Setup
* Install Rails and clone this repo
* Run `bundle install` to install gems
* Run Elasticsearch locally on port 9200
* Initialize and seed both databases by running `rake db:setup`
* Run `rails s` to start rails server on port 3000

## View Authorized Indices
The `/users/:user_name` endpoint can be used to view a list of indices that user
has access to. From the seeds, the user `foo` should have access to all four
indices and the user `baz` should have access to their own index only. Passing in
a user that does not exist returns a 404.

## View Users
The `/results` endpoint can be used to search for documents in Elasticsearch. The
request must be "authenticated" by including the user name under a `User-Name` HTTP
header.

At least one queryable field (`first_name`, `last_name`, `location`) must be included
as a query parameter. An `index` parameter may be optionally included to specify
a specific index to query. By default, all indices that the user has access to
will be queried.

### Examples:
* `/results?first_name=fred` (no user in headers) -> 401 not authorized
* `/results?first_name=fred` (invalid user in headers) -> 401 not authorized
* `/results?first_name=fred` (user foo) -> documents with first name "fred" in all indices
* `/results?first_name=fred` (user baz) -> documents with first name "baz" in baz_index
* `/results?first_name=fred&last_name=flintstone` (user foo) -> documents with first name "fred" and last name "flintstone"
* `/results` (user foo) -> 400 missing parameter
* `/results?first_name=fred&index=bar_index` (user foo) -> documents with first name "fred" in bar_index
* `/results?first_name=fred&index=bar_index` (user baz) -> 403 forbidden
