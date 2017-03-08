# encoding: utf-8
db_config = YAML.load_file('/Users/adamrenschen/Desktop/MSWebProjectsLocalRepo/indigo_rails_2/config/database.yml')['production']
##
# Backup Generated: db_backup_test
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t db_backup_test [-c <path_to_configuration_file>]
#
Backup::Model.new(:db_backup_test, 'Description for db_backup_test') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    #db.name               = "my_database_name"
    db.username           = <%= ENV["POSTGRES_USERNAME"] %>
    db.password           = <%= ENV["POSTGRES_PASSWORD"] %>
    db.host               = "localhost"
    db.port               = 5432
    db.socket             = "/tmp/pg.sock"
    #db.skip_tables        = ["skip", "these", "tables"]
    #db.only_tables        = ["only", "these", "tables"]
    db.additional_options = ["-xc", "-E=utf8"]
  end

  ##
  # SCP (Secure Copy) [Storage]
  #
  store_with SCP do |server|
    server.username   = "deployment"
    server.password   = "pass7733"
    server.ip         = "169.230.177.100"
    server.port       = 22
    server.path       = "~/backups/"
    server.keep       = 5
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "indigoprojectwebmaster@gmail.com"
    mail.to                   = "adam.renschen@ucsf.edu"
    mail.address              = "smtp.gmail.com"
    mail.port                 = 587
    mail.domain               = "your.host.name"
    mail.user_name            = "indigoprojectwebmaster@gmail.com"
    mail.password             = "hlakirucsf"
    mail.authentication       = "plain"
    mail.encryption           = :starttls
  end

end
