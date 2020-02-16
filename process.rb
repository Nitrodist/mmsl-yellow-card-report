#!/usr/bin/env ruby
#
require 'csv'
require 'pry'
require 'active_record'

ActiveRecord::Base.establish_connection('postgres://localhost/mmsl')

csv_data = CSV.parse(File.read('penalty-report-202002151117.csv'), headers: true)

# require 'sqlite3'
# db = SQLite3::Database.new(':memory:')
# db.execute(<<EOS)
#   CREATE TABLE infractions (
#     id varchar(255),
#     team_name varchar(255),
#     first_name varchar(255),
#     last_name varchar(255),
#     datetime_of_infraction TIMESTAMPTZ,
#     player_number INTEGER,
#     infraction_code varchar(255),
#     PRIMARY KEY(id)
#   )
# EOS

class Infraction < ActiveRecord::Base
end

csv_data.each do |row|
  Infraction.create(
    id: Infraction.count + 1,
    last_name: row[' Last Name'].strip,
    first_name: row['First Name'].strip,
    team_name: row['Team'].strip,
    player_number: row['#'].strip,
    infraction_code: row[' Card'].strip,
    datetime_of_infraction: DateTime.parse(row['Date'].strip + " Central Time (US & Canada)"))
end

binding.pry


exit 0
