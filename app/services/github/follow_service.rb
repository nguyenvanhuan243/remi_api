class Github::FollowService
  def initialize; end

  def follow_user(target_user)
    headers = {
      'Accept' => '*/*',
      'Accept-Language' => 'en-US,en;q=0.9,vi;q=0.8',
      'Cookie' => '',
      'Origin' => 'https://github.com',
      'Referer' => 'https://github.com/filiph?tab=followers',
      'Sec-Ch-UA' => '"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"',
      'Sec-Ch-UA-Mobile' => '?0',
      'Sec-Ch-UA-Platform' => '"macOS"',
      'Sec-Fetch-Dest' => 'empty',
      'Sec-Fetch-Mode' => 'cors',
      'Sec-Fetch-Site' => 'same-origin',
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
      'X-Requested-With' => 'XMLHttpRequest'
    }

    options = {
      headers: headers,
      body: {
        commit: 'Follow',
        authenticity_token: ENV["GITHUB_ACCESS_TOKEN"]
      }
    }

    response = HTTParty.post("https://github.com/users/follow?target=#{target_user}", options)

    if response.success?
      puts "Successfully followed #{target_user}!"
    else
      puts "Error following #{target_user}: #{response.code} - #{response.message}"
    end
  end
end
