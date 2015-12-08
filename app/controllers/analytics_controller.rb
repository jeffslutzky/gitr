class AnalyticsController < ApplicationController
  #tests
  def projects_vs_collaborators
      @projects = Project.sort_by_number_of_collaborators
         respond_to do |format|
          format.json {
            render :json => @projects
          }
        end 

  end
  




end
