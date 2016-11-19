class HlauploadsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @hlauploads = Hlaupload.all
  end

  def new
    @hlaupload = Hlaupload.new
  end

  def create #action for uploading keyfiles and parsing individual records then storing them in db.
    @failed_hlas = [] #structure to hold samples that can't be saved for any reason
    @number_hlas_added = 0 #counter for keeping track of hlas added to db
    @hlaupload = Hlaupload.new(hlaupload_params) #creating key model with imported file as the keyfile attribute value e.g. Key[:keyfile]
    if @hlaupload.save
      flash[:notice] = "File #{@hlaupload[:datafile]} successfully uploaded"
      if @hlaupload[:datafile].split(".")[1] == 'csv' #checks to see if keyfile is a .csv file
        csv_text = File.read("#{Rails.root}/hlas/#{@hlaupload.created_at.to_date}/#{@hlaupload[:datafile]}") #reads the contents of the file stored on the server and stores it in a variable. File is a built-in Rails helper class with its own methods
        csv = CSV.parse(csv_text, :headers => true) #parses the text into csv rows. the :headers => true hash means that the first line of the csv_text will be treated as column names. CSV is another built-in Rails helper class
        csv.each do |hla_data|
          if Hla.where(indigo_id: hla_data["INDIGO_ID"]).exists? #checks if a Sample with this INDIGO_ID is already in the database. Currently takes no action if sample already exists.
          else #if a sample with this INDIGO_ID doesn't exist in the db the code below creates and saves the csv row in the db.
            hla = Hla.new( indigo_id: hla_data["INDIGO_ID"], drb1_15_copies_calculated: hla_data["DRB1_15_Copies_Calculated"],
                          drb1_1: hla_data["DRB1_1"], drb1_2: hla_data["DRB1_2"], dqb1_1: hla_data["DQB1_1"], dqb1_2: hla_data["DQB1_2"],
                          dpb1_1: hla_data["DPB1_1"], dpb1_2: hla_data["DPB1_2"], a_1: hla_data["A_1"], a_2: hla_data["A_2"],
                          b_1: hla_data["B_1"], b_2: hla_data["B_2"], c_1: hla_data["C_1"], c_2: hla_data["C_2"])

            if hla.save #attempts to save the sample model to the db
              @number_hlas_added += 1
            else
              # If a sample fails to be saved (for whatever reason) we let the user know.
              @failed_hlas.add(hla_data["INDIGO_ID"])
            end #ends the if..else block
          end #ends the if exists? block
        end #ends the csv.each block
      end #ends the if @key[:keyfile].split block
      if @failed_hlas.size > 0
        flash[:notice] = "#{@failed_hlas.size} samples failed to load and were not saved"
      end
      redirect_to new_hlaupload_path
    end #ends the if @key.save block. Temporary. Soon will add in logic to accept .xslx Excel files. Need to get familiar with Roo, a gem that allows Rails to work with those files. CSV does not, apparently

  end #ends the create method

  def destroy
  end

  private

    def hlaupload_params
      params.require(:hlaupload).permit(:datafile)
    end
end
