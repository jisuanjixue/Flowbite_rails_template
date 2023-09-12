# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
Rails.logger.debug 'Seeding database'
load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))
#   Character.create(name: "Luke", movie: movies.first)
