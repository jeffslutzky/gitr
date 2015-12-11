class AnalyticsController < ApplicationController
  def index
  end

  def projects_vs_collaborators
    @projects = Project.sort_projects_and_number_of_collaborators_desc
    data = { name: [], n_collaborators: [] }
    @projects.each_with_index do |project_array,i|
      data[:name]<<project_array[0]
      data[:n_collaborators]<<project_array[1]
    end

      #  respond_to do |format|
        # format.js {
          render :json => data
        # }
    # end
  end

  def number_of_commits_for_active_projects
    names = current_user.projects.active.map {|project| project.name }
    n_commits = Project.number_of_commits_by_user_on_active_projects(current_user)
    data = { name: names, n_commits: n_commits }
    render :json => data
  end
end
