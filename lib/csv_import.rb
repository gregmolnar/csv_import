require "active_support/dependencies"

require "csv_import/mapper"
module CsvImport
    mattr_accessor :app_root
    def self.setup
      yield self
    end
end

require "csv_import/engine"