class Github::FollowUsersService
  def initialize; end

  def follow_users(start = 1, stop = 10_000_000, step = 25)
    begin
      follow_service = Github::FollowService.new
      (start..stop).step(step).to_a.each do |item|
        response = HTTParty.get("https://api.github.com/users?since=#{item}")
        JSON.parse(response.body).pluck('login').each do |target_user|
          follow_service.follow_user(target_user)
        end
      end
    rescue
      puts "You has been limited follow users"
    end
  end
end
