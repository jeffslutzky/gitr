module Adapters
  class GithubConnection
    include HTTParty
    attr_reader :connection

    def initialize
      @connection = self.class
    end

    def query(user,repo,resource)
      options = {
        headers:{
          "User-Agent" => "gitr",
          "Authorization" => "token #{ENV["GITHUB_TOKEN"]}"
        },
        body:{}
      }
      connection.get("https://api.github.com/repos/#{user}/#{repo}/#{resource}",options)

      # results = connection.get("https://api.spotify.com/v1/search", {query: query})
      # s_results = RecursiveOpenStruct.new(results, :recurse_over_arrays => true)
    end
  end
end
