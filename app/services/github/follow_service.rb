require 'octokit'

class Github::FollowService
  def initialize
    @client = Octokit::Client.new(
      access_token: ENV['GITHUB_ACCESS_TOKEN']
    )
  end

  def follow_user(target_username)
    # Follow the user on GitHub
    @client.follow(target_username)

    # { success: true, message: "Successfully followed #{target_username}" }
    puts '###############################################################################'
    puts "############################# Done #{target_username} #########################"
    puts '###############################################################################'
  rescue Octokit::NotFound
    puts "Fail #{target_username}"
  rescue Octokit::Unauthorized
    puts "Fail #{target_username}"
  rescue StandardError => e
    puts "Fail #{target_username}"
  end

end
