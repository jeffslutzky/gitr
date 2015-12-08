class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end
 # render_to_string(:action => "show.html.erb", :layout => false)
  def dashboard
    @projects = current_user.collaborator.projects.active
    render :json => @projects
  end



  def show
    # Showing all events from a repo for an activity feed
    github = Github.new user: current_user.username, repo:"#{@project.name}"
    github.oauth_token = session["user_token"]
    @repo_events = github.activity.events.public
    #binding.pry
    respond_to do |format|
      format.html { render :show }
      format.json { 
        html_string = render_to_string 'show.html.erb', layout: false
        render json: {template: html_string} 
      }
    end
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.admin = current_user.admin
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    binding.pry
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :github_id, :admin_id, :active)
    end
end
