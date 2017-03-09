class KeysController < ApplicationController
  before_action :set_key, only: [:destroy]
  before_action :authenticate_user!
  load_and_authorize_resource #Cancancan feature to prevent unauthorized access to these views and methods

  def index
    @keys = Key.all
  end

  def new
    @key = Key.new
    @keys = Key.all
  end

  def create #action for uploading keyfiles and parsing individual records then storing them in db.
    @failed_samples = [] #structure to hold samples that can't be saved for any reason
    @number_samples_added = 0 #counter for keeping track of samples added to db
    @key = Key.new(key_params) #creating key model with imported file as the keyfile attribute value e.g. Key[:keyfile]
    if @key.save
      # :gflash => {:success => "File #{@key[:keyfile]} successfully uploaded" }
      if @key[:keyfile].split(".")[1] == 'csv' #checks to see if keyfile is a .csv file
        csv_text = File.read("#{Rails.root}/indigo_keys/#{@key.created_at.to_date}/#{@key[:keyfile]}") #reads the contents of the file stored on the server and stores it in a variable. File is a built-in Rails helper class with its own methods
        csv = CSV.parse(csv_text, :headers => true) #parses the text into csv rows. the :headers => true hash means that the first line of the csv_text will be treated as column names. CSV is another built-in Rails helper class
        csv.each do |sample_data|
          if IDR.where(indigo_id: sample_data["INDIGO_ID"]).exists? #checks if an IDR with this INDIGO_ID is already in the database. Currently takes no action if sample already exists.
          else #if a sample with this INDIGO_ID doesn't exist in the db the code below creates and saves the csv row in the db.
            @idr = IDR.new(sample_source: sample_data["Sample source"], disease: sample_data["Disease"], #creates an in-memory Sample object using the parsed csv data
            indigo_id: sample_data["INDIGO_ID"], gender: sample_data["Gender"], ethnicity: sample_data["Ethnicity"],
            age_at_sample: sample_data["Age at Sample"], site_sample_id: sample_data["Sample Source ID"])
            if @idr.save

              @sample = Sample.create(sample_source: sample_data["Sample Source"], disease: sample_data["Disease"],
              indigo_id: sample_data["INDIGO_ID"], gender: sample_data["Gender"], ethnicity: sample_data["Ethnicity"],
              age_at_sample: sample_data["Age at Sample"], short_date: Time.now.strftime('%B %d %Y'),
              site_sample_id: sample_data["Sample Source ID"],idr_id: @idr.id)

              if @sample.save #attempts to save the idr model to the db
                @number_samples_added += 1
              else# If a sample fails to be saved (for whatever reason) we let the user know.
                @failed_samples.add(sample_data["INDIGO_ID"])
              end #ends the if..else block
            end #ends if @idr.save block
          end #ends the if exists? block
        end #ends the csv.each block
      elsif @key[:keyfile].split(".")[1] == 'xlsx' #checks for excel spreadsheet file type
        excel_spreadsheet = Roo::Spreadsheet.open("#{Rails.root}/indigo_keys/#{@key.created_at.to_date}/#{@key[:keyfile]}")
        excel_spreadsheet.drop(1).each do |row| #excel_spreadsheet is an array of arrays. the first array(row) are the header names which are not needed, so the .each iteration starts with the second row
          if IDR.where(indigo_id: row[1]).exists?
          else
            @idr = IDR.new(sample_source: row[2], disease: row[3], indigo_id: row[1], age_at_sample: row[6],
                                gender: row[7], ethnicity: row[5])
            if @idr.save
              sample = Sample.new(sample_source: row[2], disease: row[3], indigo_id: row[1], age_at_sample: row[6],
                                  gender: row[7], ethnicity: row[5], idr_id: @idr.id, short_date: Time.now.strftime('%d %B %Y'))

              if sample.save
                @number_samples_added += 1
              else
                @failed_samples.add(row[1])
              end
            end
          end
        end
      end #ends the if @key[:keyfile].split block
      if @failed_samples.size > 0
        # :gflash => {:notice => "#{@failed_samples.size} samples failed to load and were not saved"}
      end
      redirect_to new_key_path
    end #ends the if @key.save block.

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
