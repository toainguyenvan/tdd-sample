# README

# Overview
I created the `@basket` object as `Hash` to store all the items as Shopping Cart

# Project Structure
```
app/
    ...
    models/
        product.rb
        promotion.rb
    ...
    services/
        check_out.rb
...
spec/
    modesl/
        product_spec.rb
        promotion_spec.rb
    services/
        check_out_spec.rb
```

# Models

### Product

| Code | Name | Price |
| ------ | --------- |------|
| 001 | Lavender heart| 9.25|
| 002 | Personalised cufflinks| 45.00|
| 003 | Kids T-shirt |19.95|
| ... | ...|...|
| header 1 | header 2 |
| -------- | -------- |
| cell 1   | cell 2   |
| cell 3   | cell 4   |

```ruby
class Product < ApplicationRecord
    validates_presence_of :code, :name, :price
end
```

### Promotion
The structure like this:
```ruby
class Promotion < ApplicationRecord
	serialize :condition, Hash
	serialize :action, Hash
	validates_presence_of :name, :condition, :action
end
```
`condition` and `action` will be 2 hashes that contain these things:
For example:
```javascript
condition: { 
    quantity: { value: 2, operator: 'gte'}, 
	code: {value: '001', operator: 'e'},
	...
}, 
action: { price: 8.5,... }
```

It means whenever the User reach all the `condition` for this promotion, all the `action` will be affected.
In this example above, when we buy 2 items with code 001 => then we reach the benefit that the price for each item will be deducted as £8.5.

*Improvement*
```
Will define all attributes as much as possible, then we can easy to define the condition, the action as well
```
### How to test?

**RSPEC**
You will see something like this, no worry, just my testing.
```sh
rspec
.........Total price: 0.0
.Total price: 9.25
Total price: 9.25
.Total price: 9.25
Total price: 54.25
Total price: 66.78
.Total price: 9.25
Total price: 29.2
Total price: 36.95
.Total price: 9.25
Total price: 54.25
Total price: 55.8
Total price: 73.76
.

Finished in 0.0754 seconds (files took 5.46 seconds to load)
14 examples, 0 failures
```
After bundle install
```sh
rake:db:migrate
rake:db:seed
```
You will see something like this:
```sh
.Deleted all Products
..Deleted all Promotions
..Imported Product sample
..Imported Promotion sample
```
It means everything is ready, let play with it.

# CheckOut Service
I run this with my `rails c` command
```sh
rails c
```
Then, init the service
```sh
checkout = CheckOut.new
```
By default the CheckOut will get all promotion in the database as parameters(you can see this in the source code)
Then, try to scan some product
```sh
checkout.scan('001')
=> Total price: 9.25
```
```sh
checkout.scan('002')
=> Total price: 54.25
```
```sh
checkout.scan('003')
=> Total price: 66.78
```

# Some improvement    if I have time
> Make a scan with sequences of product code like `checkout.scan('001,002,003')`
> Make an API for the checkout service, we can integrate with whatever systems we want
> Make the promotion rules independently with the Database itself, so we just need to upload the JSON file for the Promotion table, then... works
...
That's it.
Thank for your reading



