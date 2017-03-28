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
    @number_hlas_failed = 0
    @hlaupload = Hlaupload.new(hlaupload_params)
    @hla_upload_version = @hlaupload.datafile.to_s.split('/').last
    @hlaupload[:version] = @hla_upload_version
    if @hlaupload.save #Only try to parse the uploaded file if it was successfully uploaded!
      if @hlaupload[:datafile].split(".")[1] == 'csv' #Check to see if keyfile is a .csv file
        csv_text = File.read("#{Rails.root}/hlas/#{@hlaupload.created_at.to_date}/#{@hlaupload[:datafile]}") #Read the contents of the file stored on the server and stores it in a variable. File is a built-in Rails helper class with its own methods
        csv = CSV.parse(csv_text, :headers => true) #parses the text into csv rows. the :headers => true hash means that the first line of the csv_text will be treated as column names. CSV is another built-in Rails helper class
        csv.each do |hla_data|

          @idr = IDR.find_by(indigo_id:hla_data["INDIGO_ID"], hla_version:@hlaupload_upload_version) #find an existing IDR with the uploaded indigo id and hla_version, if it exists
          @hla = Hla.find_by(indigo_id:hla_data["INDIGO_ID"], version:@hlaupload_upload_version) #find an existing Hla with the uploaded indigo id and version, if it exists

          if @idr == nil
            if IDR.find_by(indigo_id:hla_data["INDIGO_ID"], hla_version:nil) != nil #if an IDR exists with the indigo id and doesn't have any hla data (ie no version), update the existing idr
              @idr = IDR.find_by(indigo_id:hla_data["INDIGO_ID"], hla_version:nil)
              @idr.update_attributes(drb1_15_copies_calculated: hla_data["DRB1_15_Copies_Calculated"],
                            drb1_1: hla_data["DRB1_1"], drb1_2: hla_data["DRB1_2"], dqb1_1: hla_data["DQB1_1"], dqb1_2: hla_data["DQB1_2"],
                            dpb1_1: hla_data["DPB1_1"], dpb1_2: hla_data["DPB1_2"], a_1: hla_data["A_1"], a_2: hla_data["A_2"],
                            b_1: hla_data["B_1"], b_2: hla_data["B_2"], c_1: hla_data["C_1"], c_2: hla_data["C_2"],
                            dpa1_1: hla_data["DPA1_1"], dpa1_2: hla_data["DPA1_2"], dqa1_1: hla_data["DQA1_1"], dqa1_2: hla_data["DQA1_2"],
                            drbo_1: hla_data["DRBo_1"], drbo_2: hla_data["DRBo_2"], dpb1_phase_ambiguities: hla_data["DPB1 phase ambiguities"],
                            hla_version: @hlaupload_version)

            elsif IDR.where(indigo_id:hla_data["INDIGO_ID"]).count > 0 #if there is an IDR with the same indigo id, create a new one with the uploaded hla data
              @existing_idr = IDR.find_by(indigo_id:hla_data["INDIGO_ID"])
                IDR.create(sample_source: @existing_idr["Sample Source"], disease: @existing_idr["Disease"],
                            indigo_id: @existing_idr["INDIGO_ID"], gender: @existing_idr["Gender"], ethnicity: @existing_idr["Ethnicity"],
                            age_at_sample: @existing_idr["Age at Sample"],
                            site_sample_id: @existing_idr["Sample Source ID"],age_of_onset: @existing_idr["Age of Onset"],
                            drb1_15_copies_calculated: hla_data["DRB1_15_Copies_Calculated"],
                            drb1_1: hla_data["DRB1_1"], drb1_2: hla_data["DRB1_2"], dqb1_1: hla_data["DQB1_1"], dqb1_2: hla_data["DQB1_2"],
                            dpb1_1: hla_data["DPB1_1"], dpb1_2: hla_data["DPB1_2"], a_1: hla_data["A_1"], a_2: hla_data["A_2"],
                            b_1: hla_data["B_1"], b_2: hla_data["B_2"], c_1: hla_data["C_1"], c_2: hla_data["C_2"],
                            dpa1_1: hla_data["DPA1_1"], dpa1_2: hla_data["DPA1_2"], dqa1_1: hla_data["DQA1_1"], dqa1_2: hla_data["DQA1_2"],
                            drbo_1: hla_data["DRBo_1"], drbo_2: hla_data["DRBo_2"], dpb1_phase_ambiguities: hla_data["DPB1 phase ambiguities"],
                            hla_version: @hlaupload_version)
            else #no action here
            end
          end #close if @idr == nil block

          if @hla != nil
            @number_hlas_failed += 1 #add to failed counter if an hla exists with the same indigo id and version as the uploaded hla

          else #if the hla with indigo id and version doesn't exist, create it and set a fk connection to the sample
            @sample = Sample.find_by(indigo_id: hla_data["INDIGO_ID"])
            @hla = Hla.new( indigo_id: hla_data["INDIGO_ID"], drb1_15_copies_calculated: hla_data["DRB1_15_Copies_Calculated"],
                          drb1_1: hla_data["DRB1_1"], drb1_2: hla_data["DRB1_2"], dqb1_1: hla_data["DQB1_1"], dqb1_2: hla_data["DQB1_2"],
                          dpb1_1: hla_data["DPB1_1"], dpb1_2: hla_data["DPB1_2"], a_1: hla_data["A_1"], a_2: hla_data["A_2"],
                          b_1: hla_data["B_1"], b_2: hla_data["B_2"], c_1: hla_data["C_1"], c_2: hla_data["C_2"], sample_id: @sample.id,
                          dpa1_1: hla_data["DPA1_1"], dpa1_2: hla_data["DPA1_2"], dqa1_1: hla_data["DQA1_1"], dqa1_2: hla_data["DQA1_2"],
                          drbo_1: hla_data["DRBo_1"], drbo_2: hla_data["DRBo_2"], dpb1_phase_ambiguities: hla_data["DPB1 phase ambiguities"],
                          version: @hlaupload[:datafile.to_s])
            if @hla.save
              @number_hlas_added += 1
            else
              # If a sample fails to be saved (for whatever reason) we let the user know.
              @failed_hlas.add(hla_data["INDIGO_ID"])
            end #close the if hla.save block

          end #close the if @hla != nil block
        end #close the csv.each block

      elsif @hlaupload[:datafile].split(".")[1] == 'xlsx' #checks for excel spreadsheet file type
          excel_spreadsheet = Roo::Spreadsheet.open("#{Rails.root}/hlas/#{@hlaupload.created_at.to_date}/#{@hlaupload[:datafile]}")
          excel_spreadsheet.drop(1).each do |row| #excel_spreadsheet is an array of arrays. the first array(row) are the header names which are not needed, so the .each iteration starts with the second row
            if IDR.where(indigo_id: row[4]).exists?
              @idr = IDR.where(indigo_id: row[4])
              @idr.update(a_1: row[5], a_2: row[6], b_1: row[7], b_2: row[8], c_1: row[9], c_2: row[10], dpa1_1: row[11], dpa1_2: row[12], dpb1_1: row[13],
                            dpb1_2: row[14], dqa1_1: row[15], dqa1_2: row[16], dqb1_1: row[17], dqb1_2:row[18], drb1_1: row[19], drb1_2: row[20], drbo_1: row[21], drbo_2: row[22])
              if Hla.where(indigo_id: row[4]).exists?
              else
                @sample = @idr.sample
                hla = Hla.new(indigo_id: row[4], a_1: row[5], a_2: row[6], b_1: row[7], b_2: row[8], c_1: row[9], c_2: row[10], dpa1_1: row[11], dpa1_2: row[12], dpb1_1: row[13],
                              dpb1_2: row[14], dqa1_1: row[15], dqa1_2: row[16], dqb1_1: row[17], dqb1_2:row[18], drb1_1: row[19], drb1_2: row[20], drbo_1: row[21], drbo_2: row[22], sample_id: @sample.id)

                if hla.save
                  @number_hlas_added += 1
                else
                  @failed_hlas.add(row[4])
                end
              end
            end
          end
        end #close the if @hla[:datafile].split block
      if @failed_hlas.size > 0
        flash[:notice] = "#{@failed_hlas.size} samples failed to load and were not saved"
      end
      flash[:notice] = "#{@number_hlas_added} hlas added to database"
    else
      flash[:error] = "This spreadsheet has already been uploaded"
    end #close the if @hla.save block.
    redirect_to new_hlaupload_path
  end #close the create method

  def destroy
  end

  private

    def hlaupload_params
      params.require(:hlaupload).permit(:datafile)
    end
end
