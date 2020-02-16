#!/usr/bin/env ruby
#
require 'csv'
require 'pry'
require 'activerecord'

csv_data = CSV.parse(File.read('penalty-report-202002151117.csv'))

# require 'sqlite3'
# db = SQLite3::Database.new(':memory:')
# db.execute(<<EOS)
#   CREATE TABLE infractions (
#     id varchar(255),
#     team_name varchar(255),
#     first_name varchar(255),
#     last_name varchar(255),
#     date_of_infraction DATE,
#     player_number INTEGER,
#     infraction_code varchar(255),
#     PRIMARY KEY(id)
#   )
# EOS

class Infraction < ActiveRecord::Base
end

binding.pry

exit 0
