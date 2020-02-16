#!/usr/bin/env ruby

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
#     infraction_series_number INTEGER,
#     PRIMARY KEY(id)
#   )
# EOS

class Infraction < ActiveRecord::Base
end

Infraction.delete_all

csv_data.each do |row|
  next if row[' Card'] != 'Yellow Card'
  record = {
    id: Infraction.count + 1,
    last_name: row[' Last Name'].strip,
    first_name: row['First Name'].strip,
    team_name: row['Team'].strip,
    player_number: row['#'].strip,
    infraction_code: row[' Card'].strip,
    datetime_of_infraction: DateTime.parse(row['Date'].strip + " Central Time (US & Canada)"),
  }

  infraction_series_number = Infraction.where(last_name: record[:last_name], first_name: record[:first_name], team_name: record[:team_name]).count + 1

  record = Infraction.create(record.merge(infraction_series_number: infraction_series_number))

end

def generate_infraction_series_number
end

binding.pry

exit 0
