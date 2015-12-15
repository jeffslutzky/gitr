module Adapters
  class GithubConnection
    include HTTParty
    attr_reader :connection

    def initialize
      @connection = self.class
    end

    def query(user,repo,resource,per_page = 100)
      options = {
        headers:{
          "User-Agent" => "gitr",
          "Authorization" => "token #{ENV["GITHUB_TOKEN"]}"
        },
        body:{}
      }
      connection.get("https://api.github.com/repos/#{user}/#{repo}/#{resource}?page=1&per_page=#{per_page}",options)
    end

    def post(user, repo, resource)
      options = {
        headers:{
          "User-Agent" => "gitr",
          "Authorization" => "token #{ENV["GITHUB_TOKEN"]}"
        },
        body:{}
      }
      connection.put("https://api.github.com/repos/#{user}/#{repo}/#{resource}",options)
    end
  end

end
