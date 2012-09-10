class CsvImportController < ::ApplicationController
    def upload
      if request.post?
        uploaded = params[:file]
        target = Rails.root.join('tmp', uploaded.original_filename)
        logger.debug target
        File.open(target, 'w') do |file|
          file.write(uploaded.read)            
        end
        session[:csv_file] = target
        
        redirect_to eval (params[:resource] + '_csv_import_map_path')
      end
    end
    
    def map
      require 'csv'
      reader = CSV.open(session[:csv_file], 'r') 
      @heading = reader.shift  
      @model = eval(params[:model]).new
      @attributes = @model.attribute_names
    end

    def import
      reader = CSV.open(session[:csv_file], 'r') 
      reader.each do |row|
        model = eval(params[:model]).new
        params[:attributes].each do |e,i|
          model[e.to_sym] = row[i.to_i]
        end
        model.save!
      end
      flash[:notice] = "Successful import."
      File.delete(session[:csv_file])
      session[:csv_file] = nil
      redirect_to eval (params[:resource] + '_csv_import_upload_path')
    end
end