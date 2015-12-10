class SessionsController < ApplicationController


  def new
  	redirect_to '/auth/github'
	end

  def create
    @user = User.find_by_uid( auth_hash[:uid]) || User.create_from_omniauth(auth_hash)
    @user.update(
    	name: auth_hash[:info][:name],
    	provider: auth_hash[:provider],
    	username: auth_hash[:extra][:raw_info][:login],
    	avatar_url: auth_hash[:extra][:raw_info][:avatar_url]
    	)

	  if @user
      session[:user_id] = @user.id
      session[:user_token] = auth_hash[:credentials][:token]

			github = Github.new
			# github.current_options[:client_id] = ENV["GITHUB_KEY"]
			# github.current_options[:client_secret] = ENV["GITHUB_SECRET"]
      github.current_options[:oauth_token] = session[:user_token]

			login_name = auth_hash[:extra][:raw_info][:login]

      github_repos = github.repos.list user: login_name, per_page: 100
			github_repos.each do |repo|
				if !@user.admin.projects.find_by(github_repo_id: repo.id)
          collaborators = github.repos.collaborators.all  repo.owner.login, repo.name
					assign_attributes_to_repo(repo,collaborators)
				end
			end
	  end
  	redirect_to root_url
	end

	def assign_attributes_to_repo(repo,collaborators)
		project = @user.admin.projects.create({
			name: repo.name,
			github_repo_id: repo.id,
			url: repo.html_url,
			description: repo[:description]
		})
    project.get_milestones
    project.get_issues

    collaborators.each do |collaborator_hash|
      User.find_or_create_from_api(project,collaborator_hash)
    end
  end


	def destroy
    # !!!!!!!!!!!Capturing lastlogout to DB
    user = User.find_by(uid: current_user.uid)
    user.update_attribute(:lastlogout, Time.now)

	  reset_session
	  redirect_to root_url
	end

protected
  def auth_hash
    request.env['omniauth.auth']
  end


end
