module ActionDispatch::Routing
  class Mapper
    module CsvImport
      class CsvImport < ActionDispatch::Routing::Mapper::Resource
        
      end

      def csv_import_resource(*resources, &block)
        options = resources.extract_options!
        options[:model].nil? ? modelname = resource.to_s.classify : modelname = options[:model].capitalize
        resource = resources.pop
        puts resource.inspect
        yield if block_given?          
        get "#{resource.to_s}/csv_import/upload" =>  'csv_import#upload', :defaults => {:model => modelname, :resource => resource.to_s}
        post "#{resource.to_s}/csv_import/upload" =>  'csv_import#upload', :defaults => {:model => modelname, :resource => resource.to_s}
        get "#{resource.to_s}/csv_import/map" =>  'csv_import#map', :defaults => {:model => modelname, :resource => resource.to_s}
        post "#{resource.to_s}/csv_import/import" =>  'csv_import#import', :defaults => {:model => modelname, :resource => resource.to_s}
      end

    end
    include CsvImport
  end
end
