class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  before_filter :require_login

  # GET /issues
  # GET /issues.json
  def index
    @project = Project.find(params[:project_id])
    @issues = @project.issues
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
    @project = Project.find(params[:project_id])
    @issue = Issue.find(params[:id])
  end

  # POST /issues
  # POST /issues.json
  # def create
  #   @project = Project.find(params[:project_id])
  #   @issue = Issue.new(issue_params)
  #   @issue.project = @project
  #
  #     if @issue.save
  #       respond_to do |format|
  #     # begin
  #       #Github object to create new issue
  #       github = Github.new user: current_user.username, repo:"#{@project.name}"
  #       github.oauth_token = session["user_token"]
  #
  #       #Gathering milestone ID from new issues form
  #       milestone_id = params['issue']['milestones']
  #
  #       #Creating new issue on github with milestone ID
  #       github.issues.create title: "#{@issue.title}",
  #         body: "#{@issue.body}"
  #         # assignee: "octocat",
  #         # milestone: "#{milestone_id}"
  #
  #     # rescue Github::Error::ServiceError
  #     #   # notice: "You don't have access to post issues to this repo"
  #     #   # flash[:notice] = "Post NOT successfully created"
  #     #   format.html { redirect_to project_issue_path(@project, @issue), notice: 'Issue has been saved on local but you do not have access to push to remote.' }
  #     # end
  #       format.html { redirect_to project_issue_path(@project, @issue), notice: 'Issue was successfully created.' }
  #       format.json { render :show, status: :created, location: project_issue_path }
  # #
  #     else
  #       format.html { render :new, notice: 'Issue was not successfully updated.' }
  #       format.json { render json: project_issue_path.errors, status: :unprocessable_entity  }
  #
  #     end
  #   end
  # end

  def create
      @project = Project.find(params[:project_id])
      @issue = Issue.new(issue_params)
      @issue.project = @project

    respond_to do |format|
      if @issue.save

            # Github object to create new issue
             github = Github.new user: current_user.username, repo:"#{@project.name}"
             github.oauth_token = session["user_token"]

             #Gathering milestone ID from new issues form
             milestone_id = params['issue']['milestones']
      begin
             #Creating new issue on github with milestone ID
             github.issues.create title: "#{@issue.title}",
               body: "#{@issue.body}"
               # assignee: "octocat",
               # milestone: "#{milestone_id}"
     rescue Github::Error::ServiceError
       format.html { redirect_to project_issue_path(@project, @issue), notice: 'Issue has been saved on local but you do not have access to push to remote.' }
     end

        format.html { redirect_to project_issue_path(@project, @issue), notice: 'Milestone was successfully created.' }
        format.json { render :show, status: :created, location: project_issue_path }
      else
        format.html { render :new }
        format.json { render json: project_issue_path.errors, status: :unprocessable_entity }
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

  def event_handler
    ref = params["ref"]
    ref_type = params["ref_type"]
    repo_id = params["repository"]["id"]
    repo = Project.find_by(github_repo_id: repo_id)
    sender_id = params["sender"]["id"]
    sender = User.find_by(uid: sender_id)

    if params["commits"]
      ref_type = "commit"
    end

    text = "#{sender.name} has made a #{ref_type} in #{repo.name}!"
    Notification.create({
      message: text,
      user: current_user
    })
    # flash[:notice] = text
    # redirect_to "application#root"
    # render :json => {text: text}
    # redirect_to "root", turbolinks: true, flash: {notice: "Created object successfully."}
    # redirect_to root_path


    head :no_content
    return
  end

  def notifications
    new_notification = Notification.where(unread: true)
    if !new_notification.empty?
      binding.pry
      new_notification.first.unread = false
      new_notification.first.save
      render json: {data: new_notification.first.message}
    else
      render json: {data: ""}
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
