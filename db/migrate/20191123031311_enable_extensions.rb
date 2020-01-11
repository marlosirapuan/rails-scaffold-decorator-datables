class EnableExtensions < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pg_trgm'
    enable_extension 'pgcrypto'
    enable_extension 'plpgsql'
    enable_extension 'postgis'
    enable_extension 'tablefunc'
    enable_extension 'unaccent'
  end
end
