class SessionsController < ApplicationController


  def new
  	redirect_to '/auth/github'
	end

  def create
	  @user = User.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid]) || User.create_from_omniauth(auth_hash)
	  if @user
	       session[:user_id] = @user.id
	       session[:user_token] = auth_hash[:credentials][:token]
	       redirect_to user_path(current_user)
	       binding.pry
				# Github.repos.list user: "jeffslutzky"
				github = Github.new
				github.current_options[:client_id] = ENV["GITHUB_KEY"]
				github.current_options[:client_secret] = ENV["GITHUB_SECRET"]
				login_name = auth_hash[:extra][:raw_info][:login]
				github_repos = Github.repos.list user: "#{login_name}"






	  else
	       redirect_to root_url
	  end
	end

	def destroy
	  reset_session
	  redirect_to root_url
	end

protected
  def auth_hash
    request.env['omniauth.auth']
  end


end

