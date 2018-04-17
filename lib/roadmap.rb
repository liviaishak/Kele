module RoadMap

  # base_uri 'https://www.bloc.io/api/v1'

  def roadmap(chain_id)
    response = self.class.get(api_url("/roadmaps/#{chain_id}"), headers: { "authorization" => @auth_token})
    @roadmap = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_url("checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token})
    @roadmap = JSON.parse(response.body)
  end


  def get_remaining_checkpoints(chain_id)
    response = self.class.get(api_url("enrollment_chains/#{chain_id}/checkpoints_remaining_in_section"), headers: {"authorization" => @auth_token })
    @roadmap = JSON.parse(response.body)
  end

end
