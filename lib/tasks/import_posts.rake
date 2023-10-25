namespace :db do # rubocop:disable Metrics/BlockLength
  desc "Set job role and ect_status from old job_roles field"
  task import_posts: :environment do
    Post.destroy_all

    my_lambda_with_args = -> (url) {
      data = HTTParty.get(url)

      PATTERN = { "pubDate" => "published_at", "categories" => "tags" }
      response = []

      data["items"].each do |post|
        newpost = post.inject({}) do |new_hash, (k, v)|
          key = PATTERN[k] || k
          new_hash[key] = v
          new_hash
        end
        response.push(newpost)
      end

      Post.create(response)

      # if json["paging"] && json["paging"]["next"]
      #   my_lambda_with_args.call(json["paging"]["next"])
      # end
    }

    my_lambda_with_args.call("https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fmedium.com%2Ffeed%2F%40patternradio")
  end
end
