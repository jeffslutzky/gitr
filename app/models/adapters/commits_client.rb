module Adapters
  class CommitsClient

    def connection
      @connection = Adapters::GithubConnection.new
    end

    def get_commits_for_project(username, project)
      commits = connection.query(username, project.name,'commits')
      commits.each do |commit|
        new_commit = Commit.find_or_create_by(
          message: commit["commit"]["message"],
          url: commit["html_url"],
          date: DateTime.parse(commit["commit"]["author"]["date"]),
          project: project
        )

        if commit["author"]
          commit_creator = User.find_by(uid: commit["author"]["id"])
          # some project contributors are on the source repo, not a fork
          # following logic handles those cases by creating a new user
          if !commit_creator
            commit_creator = User.create(
              name: commit["commit"]["author"]["name"],
              username: commit["author"]["login"],
              uid: commit["author"]["id"],
              collaborator: Collaborator.create
            )
          end
        else
          # attribute anonymous commits to the project creator
          commit_creator = User.find_by(username: username)
        end
        new_commit.collaborator = commit_creator.collaborator
        new_commit.save
      end
    end
  end
end
