class ApiController < ApplicationController
  def subscription
    key = params.require(:subscription).permit(:endpoint)[:endpoint]
    key = key.match(/https:\/\/android\.googleapis\.com\/gcm\/send\/(.*)/)[1]

    redis.set('chrome-subscription-' + current_user.id.to_s, key)

    render nothing: true
  end

  def notify_friends
    send_notification redis.keys('chrome-subscription-*').map { |k| redis.get(key) }
  end

  def send_notification(keys)
    return unless keys.present?

    uri = URI('https://android.googleapis.com/gcm/send')
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    https.post(
      uri.path,
      { registration_ids: [keys] }.to_json,
      {
        'Content-Type' => 'application/json',
        'Authorization' => 'key=AIzaSyBqaAUMIVlwrXdU2S-4MCUvestSNchsqF0'
      }
    )

    render nothing: true
  end

  def redis
    Redis.new
  end
end
