module Adapters
  class ActivityFeedClient

    def connection
      @connection = Adapters::GithubConnection.new
    end

    def get_activity_feed_for_project(username, project)
      events = connection.query(username, project.name,'events',5)
      push_events = Project.find_push_events(events)
    end
  end
end
