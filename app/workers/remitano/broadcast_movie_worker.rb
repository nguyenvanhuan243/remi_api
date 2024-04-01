# frozen_string_literal: true

class Remitano::BroadcastMovieWorker
  include Sidekiq::Worker

  def initialize
    puts 'Remitano::BroadcastMovieWorker'
  end

  def perform(movie_id)
    movie = Movie.find(movie_id)
    content = {
      title: movie.title,
      user: movie.user.email
    }
    ActionCable.server.broadcast('movie_channel', content)
  rescue StandardError => e
    Sentry.capture_exception(e)
  end
end
