# README

## What it is 

This is a simple app done as a recruitment excersise. Here's what the requirements were:

### Requirements

A simple Product listing application that allows to:
- Add new product
- Edit existing product
- List all products
- Tag a product
- Delete an existing product

A product should have the following:
- Name
- Description
- Price

(Postman test collection was provided for verification of tech requirements)

## Running this whole thing for Postman testing

```
bundle install
rails db:create ; rails db:migrate;
rails db:seed CLEAR_DB=1
rspec spec
rails s
```

## If i had more time I would....

- [ ] introduce validation of requests and responses against JsonSchema
- [ ] improve error handling to have nice, structurized, uniformed errors convenient for frontend use
- [ ] add tests for CRUD services

