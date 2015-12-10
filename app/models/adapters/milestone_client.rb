module Adapters
  class MilestoneClient

    def connection
      @connection = Adapters::GithubConnection.new
    end

    def get_milestones_for_project(username, project)
      milestones = connection.query(username, project.name,'milestones')
      milestones.each do |milestone|
        milestone_creator_uid = milestone["creator"]["id"]
        milestone_creator = User.find_by(uid: milestone_creator_uid)
        # the following does not necessarily account for a milestone that gets modified
        milestone = Milestone.find_or_create_by(
          title: milestone["title"],
          description: milestone["description"],
          state: milestone["state"],
          project_id: project.id,
          collaborator_id: milestone_creator.collaborator.id
        )
      end
    end
  end
end
