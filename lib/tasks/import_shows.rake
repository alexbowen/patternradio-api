namespace :db do # rubocop:disable Metrics/BlockLength
  desc "Set job role and ect_status from old job_roles field"
  task import_shows: :environment do
    Show.destroy_all

    my_lambda_with_args = -> (url) {
      data = HTTParty.get(url)
      json = JSON.parse(data)
      Show.create(json["data"])

      if json["paging"] && json["paging"]["next"]
        my_lambda_with_args.call(json["paging"]["next"])
      end
    }

    my_lambda_with_args.call("https://api.mixcloud.com/patternradio/cloudcasts/")
    my_lambda_with_args.call("https://api.mixcloud.com/patternradio/favorites/")
  end
end
