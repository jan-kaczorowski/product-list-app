module RequestHelpers

  def json_headers
    {
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
  end
  def json_response
    JSON.parse response.body
  end
end
