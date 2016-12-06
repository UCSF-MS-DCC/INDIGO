class KiruploadsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @kiruploads = Kirupload.all
  end

  def new
    @kirupload = Kirupload.new
  end

  def create #action for uploading keyfiles and parsing individual records then storing them in db.
    @failed_kirs = [] #structure to hold samples that can't be saved for any reason
    @number_kirs_added = 0 #counter for keeping track of samples added to db
    @kirupload = Kirupload.new(kirupload_params) #creating Kirupload model with imported file as the keyfile attribute value e.g. Key[:keyfile]
    if @kirupload.save
      flash[:notice] = "File #{@kirupload[:datafile]} successfully uploaded"
      if @kirupload[:datafile].split(".")[1] == 'csv' #checks to see if datafile is a .csv file
        csv_text = File.read("#{Rails.root}/kirs/#{@kirupload.created_at.to_date}/#{@kirupload[:datafile]}") #reads the contents of the file stored on the server and stores it in a variable. File is a built-in Rails helper class with its own methods
        csv = CSV.parse(csv_text, :headers => true) #parses the text into csv rows. the :headers => true hash means that the first line of the csv_text will be treated as column names. CSV is another built-in Rails helper class
        csv.each do |kir_data|
          if IDR.where(indigo_id: kir_data["INDIGO_ID"]).exists?
            IDR.where(indigo_id: kir_data["INDIGO_ID"]).update(i2dl1: kir_data["2DL1"], x2dl1_2: kir_data["x2dl1_2"], i2dl2: kir_data["2DL2"],
                          x2dl2_2: kir_data["x2dl2_2"], i2dl3: kir_data["2DL3"], x2dl3_2: kir_data["x2dl3_2"], i2dl4: kir_data["2DL4"],
                          x2dl4_2: kir_data["x2dl4_2"], i2dl5a: kir_data["2DL5a"], i2dl5a_2: kir_data["2DL5a_2"], i2dl5b: kir_data["2DL5b"],
                          i2dl5b_2: kir_data["2DL5b_2"], i2dp1: kir_data["2DP1"], x2dp1_2: kir_data["x2dp1_2"], i2ds1: kir_data["2DS1"],
                          x2ds1_2: kir_data["x2ds1_2"], i2ds2: kir_data["2DS2"], x2ds2_2: kir_data["x2ds2_2"], i2ds3: kir_data["2DS3"],
                          x2ds3_2: kir_data["x2ds3_2"], i2ds4: kir_data["2DS4"], x2ds4_2: kir_data["x2ds4_2"], i2ds5: kir_data["2DS5"],
                          x2ds5_2: kir_data["x2ds5_2"], i3dl1: kir_data["3DL1"], x3dl1_2: kir_data["x3dl1_2"], i3dl2: kir_data["3DL2"],
                          x3dl2_2: kir_data["x3dl2_2"], i3dl3: kir_data["3DL3"], x3dl3_2: kir_data["x3dl3_2"], i3dp1: kir_data["3DP1"],
                          x3dp1_2: kir_data["x3dp1_2"], i3ds1: kir_data["3DS1"], x3ds1_2: kir_data["x3ds1_2"])
            if Kir.where(indigo_id: kir_data["INDIGO_ID"]).exists? #checks if a Kir with this INDIGO_ID is already in the database. Currently takes no action if sample already exists.
            else #if a sample with this INDIGO_ID doesn't exist in the db the code below creates and saves the csv row in the db.
              @sample = Sample.where(indigo_id: kir_data["INDIGO_ID"])
              kir = Kir.new(indigo_id: kir_data["INDIGO_ID"], i2dl1: kir_data["2DL1"], x2dl1_2: kir_data["x2dl1_2"], i2dl2: kir_data["2DL2"],
                            x2dl2_2: kir_data["x2dl2_2"], i2dl3: kir_data["2DL3"], x2dl3_2: kir_data["x2dl3_2"], i2dl4: kir_data["2DL4"],
                            x2dl4_2: kir_data["x2dl4_2"], i2dl5a: kir_data["2DL5a"], i2dl5a_2: kir_data["2DL5a_2"], i2dl5b: kir_data["2DL5b"],
                            i2dl5b_2: kir_data["2DL5b_2"], i2dp1: kir_data["2DP1"], x2dp1_2: kir_data["x2dp1_2"], i2ds1: kir_data["2DS1"],
                            x2ds1_2: kir_data["x2ds1_2"], i2ds2: kir_data["2DS2"], x2ds2_2: kir_data["x2ds2_2"], i2ds3: kir_data["2DS3"],
                            x2ds3_2: kir_data["x2ds3_2"], i2ds4: kir_data["2DS4"], x2ds4_2: kir_data["x2ds4_2"], i2ds5: kir_data["2DS5"],
                            x2ds5_2: kir_data["x2ds5_2"], i3dl1: kir_data["3DL1"], x3dl1_2: kir_data["x3dl1_2"], i3dl2: kir_data["3DL2"],
                            x3dl2_2: kir_data["x3dl2_2"], i3dl3: kir_data["3DL3"], x3dl3_2: kir_data["x3dl3_2"], i3dp1: kir_data["3DP1"],
                            x3dp1_2: kir_data["x3dp1_2"], i3ds1: kir_data["3DS1"], x3ds1_2: kir_data["x3ds1_2"], sample_id: @sample[0].id)
                            # the i before column names is strictly for db workability, since ruby symbols (and thus model "keys") can't start with a number.
              if kir.save #attempts to save the sample model to the db
                @number_kirs_added += 1
              else
                # If a sample fails to be saved (for whatever reason) we let the user know.
                @failed_kirs.add(kir_data["INDIGO_ID"])
              end #ends the if..else block
            end #ends the if Kir exists? block
          end #ends the if IDR exists? block
        end #ends the csv.each block
      elsif @kirupload[:datafile].split(".")[1] == 'xlsx' #checks for excel spreadsheet file type
        excel_spreadsheet = Roo::Spreadsheet.open("#{Rails.root}/kirs/#{@kir.created_at.to_date}/#{@kir[:datafile]}")
        excel_spreadsheet.drop(1).each do |row| #excel_spreadsheet is an array of arrays. the first array(row) are the header names which are not needed and so are 'dropped', so the .each iteration starts with the second row
          if Kir.where(indigo_id: row[4]).exists?
          else
            # kir = Kir.new()#waiting on the order in which the genes are listed in the Spreadsheet
            #
            # if kir.save
            #   @number_kirs_added += 1
            # else
            #   @failed_kirs.add(row[3])
            # end #ends if else
          end #ends if Kir.where if else
        end #ends .each statement
      end #ends the if @key[:keyfile].split block
    end #ends the if @kir.save block.
    if @failed_kirs.size > 0
      flash[:notice] = "#{@failed_kirs.size} kirs failed to load and were not saved"
    end
    redirect_to new_kirupload_path
    flash[:notice] = "#{@number_kirs_added} added to database:"
  end #ends the create method

  def destroy
  end

  private

    def kirupload_params
      params.require(:kirupload).permit(:datafile)
    end

end
