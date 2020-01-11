# Load the Rails application.
require_relative 'application'

# Fix: error cannot drop table spatial_ref_sys
ActiveRecord::SchemaDumper.ignore_tables = ["spatial_ref_sys"]

# Initialize the Rails application.
Rails.application.initialize!
