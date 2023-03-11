require 'video_info'
class MovieService
  def initialize(url)
    @url = url
  end

  def video_info
    video = VideoInfo.new(@url)
    { title: video.title, description: video.description, embed_url: video.embed_url }
  end
end
