module Adapters
  class IssuesClient

    def connection
      @connection = Adapters::GithubConnection.new
    end

    def get_issues_for_project(username, project)
      issues = connection.query(username, project.name,'issues')
      issues.each do |issue|
        issue_creator_uid = issue["user"]["id"]
        issue_creator = User.find_by(uid: issue_creator_uid)
        # the following does not necessarily account for an issue that gets modified
        Issue.find_or_create_by(
          title: issue["title"],
          body: issue["body"],
          state: issue["state"],
          project_id: project.id,
          collaborator_id: issue_creator.collaborator.id
        )
      end
    end
  end
end
