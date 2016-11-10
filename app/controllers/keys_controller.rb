class KeysController < ApplicationController
  before_action :set_key, only: [:destroy]
  
  load_and_authorize_resource #Cancancan feature to prevent unauthorized access to these views and methods

  def index
    @keys = Key.all
  end

  def new
    @key = Key.new
  end

  def create #action for uploading keyfiles and parsing individual records then storing them in db.
    @failed_samples = [] #structure to hold samples that can't be saved for any reason
    @number_samples_added = 0 #counter for keeping track of samples added to db
    @key = Key.new(key_params) #creating key model with imported file as the keyfile attribute value e.g. Key[:keyfile]
    if @key.save
      if @key[:keyfile].split(".")[1] == 'csv' #checks to see if keyfile is a .csv file
        csv_text = File.read("#{Rails.root}/indigo_keys/#{@key.created_at.to_date}/#{@key[:keyfile]}") #reads the contents of the file stored on the server and stores it in a variable. File is a built-in Rails helper class with its own methods
        csv = CSV.parse(csv_text, :headers => true) #parses the text into csv rows. the :headers => true hash means that the first line of the csv_text will be treated as column names. CSV is another built-in Rails helper class
        csv.each do |sample_data|
          if Sample.where(indigo_id: sample_data["INDIGO_ID"]).exists? #checks if a Sample with this INDIGO_ID is already in the database. Currently takes no action if sample already exists.
          else #if a sample with this INDIGO_ID doesn't exist in the db the code below creates and saves the csv row in the db.
            sample = Sample.new(site: sample_data["Site"], disease: sample_data["Disease"], #creates an in-memory Sample object using the parsed csv data
            received_date: sample_data["Date_Sample_Received"], indigo_id: sample_data["INDIGO_ID"],
            site_sample_id: sample_data["Site_Sample_ID (Local_ID)"], batch: sample_data["Batch"],
            sent_date: sample_data["Date_Sent_To_Stanford"], sex: sample_data["Sex"], ethnicity: sample_data["Ethnicity"])

            if sample.save #attempts to save the sample model to the db
              @number_samples_added += 1
            else
              # If a sample fails to be saved (for whatever reason) we let the user know.
              @failed_samples.add(sample_data["INDIGO_ID"])
            end #ends the if..else block
          end #ends the if exists? block
        end #ends the csv.each block
      end #ends the if @key[:keyfile].split block
      redirect_to new_key_path
    end #ends the if @key.save block. Temporary. Soon will add in logic to accept .xslx Excel files. Need to get familiar with Roo, a gem that allows Rails to work with those files. CSV does not, apparently

  end #ends the create method

  def destroy
  end

  private

    def key_params
      params.require(:key).permit(:keyfile)
    end

    def set_key
      @key = Key.find(params[:id])
    end

end
