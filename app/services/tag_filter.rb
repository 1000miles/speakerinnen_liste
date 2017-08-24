class TagFilter
  def initialize(tags, params)
    @tags = tags
    @params = params
  end

  def filter
    @tags = @tags
      .includes(:categories, :tag_languages)
      .references(:categories, :tag_languages)
    if @params[:category_id].present?
      @tags = @tags.where('categories.id = ?', @params[:category_id])
    end

    if @params[:q].present?
      @tags = @tags.where('tags.name ILIKE ?', '%' + @params[:q] + '%')
    end

    if @params[:uncategorized].present?
      @tags = @tags.where('categories.id IS NULL')
    end

    if @params[:language].present?
      @tags = @tags.where('tag_languages.language = ?', @params[:language])
    end

    if @params[:no_language].present?
      @tags = @tags.where('tag_languages.id IS NULL')
    end
    @tags
  end
end
