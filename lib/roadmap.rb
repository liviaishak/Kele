module RoadMap

  def roadmap(chain_id)
    response = self.class.get('https://www.bloc.io/api/v1/roadmaps/#{chain_id}',
      headers: { "authorization" => @auth_token})
    @roadmap = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get('https://www.bloc.io/api/v1/checkpoints/id#{checkpoint_id}',
      headers: { "authorization" => @auth_token})
    @roadmap = JSON.parse(response.body)
  end
end
