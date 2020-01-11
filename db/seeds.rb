# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Disable audit
PaperTrail.enabled = false

users = [
  ['admin', 'admin@admin.com', 'admin', true]
]

users.each do |name, email, password, is_admin|
  ActiveRecord::Base.transaction do
    user = User.find_or_initialize_by(email: email)
    user.update!(
      name: name,
      email: email,
      password: password,
      password_confirmation: password,
      status: 'enabled',
      is_admin: is_admin
    )
  end
end

# Enable audit
PaperTrail.enabled = true
