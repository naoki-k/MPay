module BrowsedPlacesHelper
  def browsed_places(limit: nil, without_place_id: nil)
    content_tag(:div, nil, data: {
        controller: "browsed_places",
        target: "browsed_places.container",
        "browsed_places-limit": limit,
        "browsed_places-without_place_id": without_place_id
    })
  end
end
