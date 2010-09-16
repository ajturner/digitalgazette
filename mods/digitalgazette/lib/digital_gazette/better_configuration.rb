  #
  # Configuration over convention :)
  # NOTE this will help us to make this behaviour easier enabled
  # and configured in mods / sites TODO put it into Conf.

  PATHS_FOR_BOXES =
    { :most_viewed => [["most_viewed"],["limit",5]],
    :recent => [["limit",5],["ascending","created_at"]]}.freeze

  HEADERS_FOR_PAGE_TYPES = {
    "wiki" => true,
    "asset" => true,
  }

  # TODO move all this into Conf
  SEARCHABLE_PAGE_TYPES = ["wiki","asset","map","overlay"].freeze

  EXTERNAL_PAGE_TYPES = ["overlay", "map"].freeze

  LEGAL_PARTIALS = ["pages/list","overlays/list","pages/box"].freeze

  PAGE_TYPE_PARTIALS = {
    "wiki" => "pages/list",
    "asset" => "pages/list",
    "map" => "pages/list",
    "overlay" => "pages/list"
  }.freeze

  BOX_PARTIALS = {
    "recent" => "pages/box",
    "most_viewed" => "pages/box"
  }.freeze