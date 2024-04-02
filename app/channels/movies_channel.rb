class MoviesChannel < ApplicationCable::Channel
  def subscribed
    return reject if current_user.nil?

    stream_from 'movie_channel'
  end

  def unsubscribed
    return reject if current_user.nil?

    stop_all_streams
  end
end
