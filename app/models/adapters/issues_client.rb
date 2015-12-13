module Adapters
  class IssuesClient

    def connection
      @connection = Adapters::GithubConnection.new
    end

    def get_issues_for_project(username, project)
      issues = connection.query(username, project.name,'issues')
      issues.each do |issue|
        # the following does not necessarily account for an issue that gets modified
        new_issue = Issue.find_or_create_by(
          title: issue["title"],
          body: issue["body"],
          date: DateTime.parse(issue["updated_at"]),
          state: issue["state"],
          project_id: project.id
        )

        issue_creator_uid = issue["user"]["id"]
        issue_creator = User.find_by(uid: issue_creator_uid)
        if issue_creator
          new_issue.collaborator = issue_creator.collaborator
        else
          # attribute anonymous issues to the project creator
          new_issue.collaborator = project.user.collaborator
        end
      end
    end
  end
end
