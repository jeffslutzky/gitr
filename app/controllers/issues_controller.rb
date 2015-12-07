class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
    @project = Project.find(params[:project_id])
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @project = Project.find(params[:project_id])
  end

  # GET /issues/new
  def new
    @issue = Issue.new
    @project = Project.find(params[:project_id])
  end

  # GET /issues/1/edit
  def edit
    @issue = issue.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)
    @project = Project.find(params[:project_id])

    respond_to do |format|
      if @issue.save

        #Create New issue
        github = Github.new user: current_user.username, repo:"#{@project.name}"
        github.oauth_token = session["user_token"]

        github.issues.create title: @issue.title,
          body: @issue.body,
          # assignee: "octocat",
          milestone: 1

        format.html { redirect_to project_milestone_path(@project, @issue), notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: project_issue_path }
      else
        format.html { render :new, notice: 'Issue was not successfully updated.' }
        format.json { render json: project_issue_path.errors, status: :unprocessable_entity  }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to project_issue_path, notice: 'Milestone was successfully updated.'  }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:title, :body, :milestone_id, :created_at, :closed_at)
    end
end
