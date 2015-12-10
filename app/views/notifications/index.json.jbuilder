json.array! @notifications do |notification|
  json.id notification.id
  json.recipient notification.recipient.name
  json.actor notification.actor.name
  json.action notification.action
  json.notifiable do
    notification = notification.notifiable.class.to_s.humanize.downcase
    if notification == "friendship"
      json.type "a friend request"
    else
      json.type "a #{notification.notifiable.class.to_s.humanize.downcase}"
    end
  end
  json.url user_friends_path
end
