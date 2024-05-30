### Hexlet tests and linter status:
[![Actions Status](https://github.com/Avanera/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Avanera/rails-project-63/actions)

# HexletCode
HexletCode provides functionality for generating HTML tags.
It includes a DSL-based form generator that simplifies the creation of forms,
similar to Simple Form in the Rails world but with a simpler architecture.

## Usage
Here's how to use the HexletCode gem to generate HTML forms based on the data of an object:

```
require 'hexletcode'

User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'
```
Generating Form Fields Based on Object Data.

You can specify additional attributes for the fields using a hash as the last parameter.
```
form_html = HexletCode.form_for user, url: '#' do |f|
  f.input :name, class: 'user-input'
  f.input :job
end

puts form_html
# Output:
# <form action="#" method="post">
#   <input name="name" type="text" value="rob" class="user-input">
#   <input name="job" type="text" value="hexlet">
# </form>
```
Using Default Values for Fields.

Fields can have default values that can be overridden.
```
form_html = HexletCode.form_for user do |f|
  f.input :job, as: :text
end

puts form_html
# Output:
# <form action="#" method="post">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>
```
You can also specify custom values for default attributes.
```
form_html = HexletCode.form_for user, url: '#' do |f|
  f.input :job, as: :text, rows: 50, cols: 50
end

puts form_html
# Output:
# <form action="#" method="post">
#   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# </form>
```
