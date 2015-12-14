module Adapters
  class ActivityFeedClient

    def connection
      @connection = Adapters::GithubConnection.new
    end

    def get_activity_feed_for_project(username, project)
      events = connection.query(username, project.name,'events')
      push_events = Project.find_push_events(events)


      # commits.each do |commit|
      #   new_commit = Commit.find_or_create_by(
      #     message: commit["commit"]["message"],
      #     url: commit["html_url"],
      #     date: DateTime.parse(commit["commit"]["author"]["date"]),
      #     project: project
      #   )
      #
      #   if commit["author"]
      #     commit_creator = User.find_by(uid: commit["author"]["id"])
      #     if !commit_creator
      #       commit_creator = User.create(
      #         name: commit["commit"]["author"]["name"],
      #         username: commit["author"]["login"],
      #         uid: commit["author"]["id"]
      #       )
      #     end
      #   else
      #     # attribute anonymous commits to the project creator
      #     commit_creator = User.find_by(username: username)
      #   end
      #   new_commit.collaborator = commit_creator.collaborator
      #   new_commit.save
      # end
    end
  end
end
