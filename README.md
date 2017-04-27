# README

The Palermo Point of Sale program is a POS used by Palermo Pizza in Caledonia, Michigan.

The program is written using Ruby on Rails, for an Ubuntu server.

To run the Palermo Point of Sale (after forking project):

- Install Ruby on Rails (see RVM)
- Enter the PalermoPOS directory
- run `bundle install` to import all necessary Gem
- run `rake install:all` to import data to the database

This command will create the following REQUIRED data:
- Admin user
- User roles
- Palconfig records

It will also optionally import from csvs in the /install/dbimport directory.
- Categories
- Products
- Options
- Customers

Start the server by `rails s`