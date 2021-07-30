# README

* How to setup app
1. Please add development.key and test.key to /config/credentials directory (I sent it to you by email)
2. Run `rake populate_movies`
3. Run `rake sync_movies`

* Docs

It is at /swagger/v1/swagger.yaml - You can display it as web page on /api-docs

* Extra notes

To make it production-ready, I would add the Admin model and token authentication to the internal controllers module - I don't have enough time to do it.

I used rsawg gem to generate swagger documentation from specs. It's cool for simple projects.
I would use JSONAPI response data format, but it's not supported by rswag.

I didn't create `An endpoint in which their customers (i.e. moviegoers) can leave a review rating (from 1-5 stars) about a particular movie`.

