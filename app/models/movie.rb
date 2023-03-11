class Movie < ApplicationRecord
  include Filterable
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :embed_url, presence: true
  validates :embed_url, uniqueness: true

  scope :filter_by_title, lambda { |search_key|
    search_key = search_key.downcase
    if search_key == 'smart contract'
      smart_contract_list = ['web3', 'smart contract', 'blockchain', 'defi', 'gamefi', 'solidity', 'ethereum']
      return where('title iLIKE ?', "%#{smart_contract_list[0]}%")
             .or(where('title iLIKE ?', "%#{smart_contract_list[1]}%"))
             .or(where('title iLIKE ?', "%#{smart_contract_list[2]}%"))
             .or(where('title iLIKE ?', "%#{smart_contract_list[3]}%"))
             .or(where('title iLIKE ?', "%#{smart_contract_list[4]}%"))
             .or(where('title iLIKE ?', "%#{smart_contract_list[5]}%"))
             .or(where('title iLIKE ?', "%#{smart_contract_list[6]}%"))
    end

    if search_key == 'music'
      music_list = ['music', 'entertainment', 'son tung', 'hat', 'nhac', 'giai tri', 'karaoke', 'acoustic']
      return where('title iLIKE ?', "%#{music_list[0]}%")
             .or(where('title iLIKE ?', "%#{music_list[1]}%"))
             .or(where('title iLIKE ?', "%#{music_list[2]}%"))
             .or(where('title iLIKE ?', "%#{music_list[3]}%"))
             .or(where('title iLIKE ?', "%#{music_list[4]}%"))
             .or(where('title iLIKE ?', "%#{music_list[5]}%"))
             .or(where('title iLIKE ?', "%#{music_list[6]}%"))
    end

    if search_key == 'guitar'
      guitar_list = ['guitar', 'fingerstyle', 'dem hat guitar', 'acoustic', 'classic']
      return where('title iLIKE ?', "%#{guitar_list[0]}%")
             .or(where('title iLIKE ?', "%#{guitar_list[1]}%"))
             .or(where('title iLIKE ?', "%#{guitar_list[2]}%"))
             .or(where('title iLIKE ?', "%#{guitar_list[3]}%"))
             .or(where('title iLIKE ?', "%#{guitar_list[4]}%"))
    end

    if search_key == 'piano'
      piano_list = %w[piano music]
      return where('title iLIKE ?', "%#{piano_list[0]}%")
             .or(where('title iLIKE ?', "%#{piano_list[1]}%"))
    end

    if search_key == 'game'
      game_list = ['game', 'gamefi', 'game hay']
      return where('title iLIKE ?', "%#{game_list[0]}%")
             .or(where('title iLIKE ?', "%#{game_list[1]}%"))
             .or(where('title iLIKE ?', "%#{game_list[2]}%"))
    end

    if search_key == 'blockchain'
      blockchain_list = ['blockchain', 'bitcoin', 'token', 'move to earn', 'gamefi', 'learn to earn', 'token', 'coin']
      return where('title iLIKE ?', "%#{blockchain_list[0]}%")
             .or(where('title iLIKE ?', "%#{blockchain_list[1]}%"))
             .or(where('title iLIKE ?', "%#{blockchain_list[2]}%"))
             .or(where('title iLIKE ?', "%#{blockchain_list[3]}%"))
             .or(where('title iLIKE ?', "%#{blockchain_list[4]}%"))
             .or(where('title iLIKE ?', "%#{blockchain_list[5]}%"))
             .or(where('title iLIKE ?', "%#{blockchain_list[6]}%"))
             .or(where('title iLIKE ?', "%#{blockchain_list[7]}%"))
    end

    if search_key == 'code'
      code_list = %w[code php rails ruby]
      return where('title iLIKE ?', "%#{code_list[0]}%")
             .or(where('title iLIKE ?', "%#{code_list[1]}%"))
             .or(where('title iLIKE ?', "%#{code_list[2]}%"))
             .or(where('title iLIKE ?', "%#{code_list[3]}%"))
    end

    if search_key == 'trading'
      trading_list = %w[trading future indicator indicators]
      return where('title iLIKE ?', "%#{trading_list[0]}%")
             .or(where('title iLIKE ?', "%#{trading_list[1]}%"))
             .or(where('title iLIKE ?', "%#{trading_list[2]}%"))
             .or(where('title iLIKE ?', "%#{trading_list[3]}%"))
    end

    if search_key == 'remitano'
      remitano_list = %w[remitano bitcoin token coin thuanCapital analytics]
      return where('title iLIKE ?', "%#{remitano_list[0]}%")
             .or(where('title iLIKE ?', "%#{remitano_list[1]}%"))
             .or(where('title iLIKE ?', "%#{remitano_list[2]}%"))
             .or(where('title iLIKE ?', "%#{remitano_list[3]}%"))
             .or(where('title iLIKE ?', "%#{remitano_list[4]}%"))
             .or(where('title iLIKE ?', "%#{remitano_list[5]}%"))
    end

    return where('title iLIKE ?', "%#{search_key}%")
  }

  # Instant Method
  def shared_by
    User.find_by(id: user_id).email
  end

  def total_likes
    likes(status: Like::statuses[:like]).size
  end

  def total_dislikes
    likes(status: Like::statuses[:dislike]).size
  end
end
