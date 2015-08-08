json.array!(@boards) do |board|
  json.extract! board, :id, :url_fragment
  json.url board_url(board, format: :json)
end
