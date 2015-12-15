class DashboardController < ApplicationController
  protect_from_forgery except: :event_handler

  def root
  end

  def event_handler
    ref = params["ref"]
    ref_type = params["ref_type"]
    repo_id = params["repository"]["id"]
    repo = Project.find_by(github_repo_id: repo_id)
    sender_id = params["sender"]["id"]
    sender = User.find_by(uid: sender_id)

    if params["commits"]
      ref_type = "commit"
    end

    text = "#{sender.name} just pushed a #{ref_type} in #{repo.name}!"
    Notification.create({
      message: text,
      user: current_user
    })

    head :no_content
    return
  end

  def notifications
    new_notification = Notification.where(unread: true)
    if !new_notification.empty?
      new_notification.first.unread = false
      new_notification.first.save
      render json: {data: new_notification.first.message}
    else
      render json: {data: ""}
    end
  end

end
