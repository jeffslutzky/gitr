module Adapters
  class LanguageStatisticsClient

    def connection
      @connection = Adapters::GithubConnection.new
    end

    def get_language_statistics_for_project(username, project)
      languages = connection.query(username, project.name,'languages')
      language_statistics = Project.find_language_statistics(languages)
    end
  end
end
