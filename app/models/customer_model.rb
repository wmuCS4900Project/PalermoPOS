class Customer < ActiveRecord::Base
    set_table_name "customers"
    set_primary_key :cust_id
end