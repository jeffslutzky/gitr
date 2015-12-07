class MilestonesController < ApplicationController
  before_action :set_milestone, only: [:show, :edit, :update, :destroy]

  # GET /milestones
  # GET /milestones.json
  def index
    @milestones = Milestone.all
    @project = Project.find(params[:project_id])
  end

  # GET /milestones/1
  # GET /milestones/1.json
  def show
    @milestone = Milestone.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  # GET /milestones/new
  def new
    @milestone = Milestone.new
    @project = Project.find(params[:project_id])
  end

  # GET /milestones/1/edit
  def edit
    @milestone = Milestone.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  # POST /milestones
  # POST /milestones.json
  def create
    @milestone = Milestone.new(milestone_params)
    @project = Project.find(params[:project_id])

    respond_to do |format|
      if @milestone.save

        #Create New Milestone on Github API (Post Request)
        github = Github.new user: 'benstew', repo:"#{@project.name}"
        github.oauth_token = session["user_token"]

        github.issues.milestones.create title: "#{@milestone.title}",
          state: "#{@milestone.state}",
          description: "#{@milestone.description}"
            #   due_on: "Time"


        format.html { redirect_to project_milestone_path(@project, @milestone), notice: 'Milestone was successfully created.' }
        format.json { render :show, status: :created, location: project_milestone_path }
      else
        format.html { render :new }
        format.json { render json: project_milestone_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /milestones/1
  # PATCH/PUT /milestones/1.json
  def update
    respond_to do |format|
      if @milestone.update(milestone_params)
        format.html { redirect_to project_milestone_path, notice: 'Milestone was successfully updated.' }
        format.json { render :show, status: :ok, location: project_milestone_path }
      else
        format.html { render :edit }
        format.json { render json: project_milestone_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milestones/1
  # DELETE /milestones/1.json
  def destroy
    @milestone.destroy
    respond_to do |format|
      format.html { redirect_to milestones_url, notice: 'Milestone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_milestone
      @milestone = Milestone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def milestone_params
      params.require(:milestone).permit(:title, :description, :state, :project_id)
    end
end
