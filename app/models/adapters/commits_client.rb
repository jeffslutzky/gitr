module Adapters
  class CommitsClient

    def connection
      @connection = Adapters::GithubConnection.new
    end

    def get_commits_for_project(username, project)
      commits = connection.query(username, project.name,'commits')
      commits.each do |commit|
        commit = Commit.find_or_create_by(
          message: commit["commit"]["message"],
          url: commit["html_url"],
          date: DateTime.parse(commit["commit"]["author"]["date"]),
          project: project
        )

        commit_creator_uid = commit["author"]
        commit_creator = User.find_by(uid: commit_creator_uid)
        if commit_creator
          commit.collaborator = commit_creator.collaborator
        end
      end
    end
  end
end
