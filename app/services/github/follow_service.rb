require 'octokit'

class Github::FollowService
  def initialize
    @client = github_client
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

  private

  def github_client
    token = ENV['GITHUB_ACCESS_TOKEN']
    raise StandardError, 'GitHub access token not found in environment variables' if token.nil? || token.empty?

    Octokit::Client.new(access_token: token)
  end
end
