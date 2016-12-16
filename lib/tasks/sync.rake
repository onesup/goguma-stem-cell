namespace :sync do
  desc 'Import production data into the local database.'
  task db: :environment do
    database = "goguma_#{Rails.env}"
    production_db = 'goguma_production'
    if database.downcase! != 'production'
      start = Time.zone.now
      host = "goguma.dffdf.xyz"
      account = "-uroot -p#{production_db} -p --single-transaction --routines --triggers"
      dump = "ssh rails@#{host} mysqldump #{account} #{production_db} --opt --compress"
      sync = "#{dump} | mysql -uroot #{database}"
      puts sync
      system(sync)
      elapsed_time = Time.zone.now - start
      puts(Time.at(elapsed_time).utc.strftime('%M:%S'))
    end
  end
end
