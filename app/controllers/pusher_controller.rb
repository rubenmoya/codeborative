class PusherController < ApplicationController
  protect_from_forgery except: :auth

  def auth
    render(text: "Forbidden", status: "403") && return unless current_user

    channel = Pusher[params[:channel_name]]
    response = channel.authenticate(params[:socket_id], user_id: current_user.id,
                                                        user_info: {
                                                          name: current_user.name,
                                                          email: current_user.email
                                                        })
    render(json: response)
  end
end
