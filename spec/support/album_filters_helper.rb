module AlbumFiltersHelper
  def generate_filter_query(query)
    keywords_count = query.split(",").size
    return query if keywords_count == 1

    query.split(",")
  end
end
