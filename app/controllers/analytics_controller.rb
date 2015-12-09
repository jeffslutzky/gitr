class AnalyticsController < ApplicationController
  #tests
  def index
  end

  def projects_vs_collaborators
      @projects = Project.sort_projects_and_number_of_collaborators_desc
      # binding.pry
      data = { name: [], n_collaborators: [] }
      # data = []
      @projects.each_with_index do |project_array,i|
        # data << {name: project_array[0], n_collaborators: project_array[1]}
        data[:name]<<project_array[0]
        data[:n_collaborators]<<project_array[1]
        # names << project_array[0]
        # no_collaborators << project_a
      end
      # @projects
      # @projects is now a hash with a 'project name' key and 'number of collaborators' value
      # but we want two arrays?

        #  respond_to do |format|
          # format.js {
            render :json => data
          # }
      # end
  end





end
