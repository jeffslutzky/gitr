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
    @projects = current_user.first.projects.sort_by_number_of_commits.active
    data = { name: [], n_commits: [] }
    @projects.each_with_index do |project_array,i|
      data[:name]<<project_array[0]
      data[:n_collaborators]<<project_array[1]
    end
    render :json => data
  end





end
