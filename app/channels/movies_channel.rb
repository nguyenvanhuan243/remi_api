class MoviesChannel < ApplicationCable::Channel
  def subscribed
    return reject if current_user.nil?

    stream_from "movie_channel"
  end

  def unsubscribed
    return reject if current_user.nil?

    stop_all_streams
  end

end

# ws://localhost:3001/cable?token=Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0fQ.jC-AGFRSGTLIvMIEMlldjyrEZ7ASyM6kiegxnziSGb4

# ActionCable.server.broadcast "movie_channel", author: 'DHH', content: 'Rails is just swell'

# ActionCable.server.broadcast("movies_for_4", "adsfdfsfdfafd")
# MoviesChannel.broadcast_to(
#   "all",
#   title: 'New things!',
#   body: 'All the news fit to print'
# )

# ActionCable.server.broadcast("movies_for_4", { body: "This Room is Best Room." })
